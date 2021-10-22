#!/bin/bash
#SBATCH -p gpu20
#SBATCH -t 10:00:00
#SBATCH -o dil_asc_adapter_mask_mixup_1-%j.out
#SBATCH --gres gpu:1


for id in 2
do
    python run.py \
    --note random$id,last_id\
    --ntasks 10 \
    --task mnist \
    --scenario dil_classification \
    --idrandom $id \
    --approach mlp_hat_ncl \
    --eval_batch_size 128 \
    --train_batch_size 128 \
    --last_id \
    --model_path "./models/fp32/dil_classification/mnist/mlp_hat_$id" \
    --save_model
done
#--nepochs 1
#    --train_batch_size 128 \
#-m torch.distributed.launch --nproc_per_node=2
#    --distributed \
#    --multi_gpu \
#    --ngpus 2

#    --lr 0.05 \
#    --lr_min 1e-4 \
#    --lr_factor 3 \
#    --lr_patience 5 \
#    --clipgrad 10000

#semantic cap size 1000, 500, 2048

#    --model_path "./models/fp32/dil_classification/celeba/cnn_hat_amix_ent_$id" \
#    --save_model