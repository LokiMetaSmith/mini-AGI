import torch

class IndexReadDML(torch.autograd.Function):
    @staticmethod
    def forward(ctx, src, index):
        ctx.save_for_backward(index)
        ctx.src_shape = src.shape
        return src[index]

    @staticmethod
    def backward(ctx, grad_output):
        index, = ctx.saved_tensors
        shape = ctx.src_shape
        grad_src = torch.zeros(shape, device=grad_output.device, dtype=grad_output.dtype)

        # Out-of-place index_add for backward to bypass DML in-place limits
        # Using a flattened 1D approach
        if len(shape) > 1:
            D = shape[1]
            grad_src = grad_src.view(-1)
            flat_idx = index.unsqueeze(1) * D + torch.arange(D, device=index.device)
            grad_src = grad_src.index_add(0, flat_idx.view(-1), grad_output.reshape(-1))
            grad_src = grad_src.view(shape)
        else:
            grad_src = grad_src.index_add(0, index, grad_output)

        return grad_src, None

def index_read(src, index):
    return IndexReadDML.apply(src, index)
