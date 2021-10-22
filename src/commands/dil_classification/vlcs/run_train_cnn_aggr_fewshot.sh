#!/bin/bash
#SBATCH -p gpu20
#SBATCH -t 20:00:00
#SBATCH -o dil_asc_adapter_mask_mixup_1-%j.out
#SBATCH --gres gpu:1


for id in 0 1 2 3 4
do
    CUDA_VISIBLE_DEVICES=0 python run.py \
    --bert_model 'bert-base-uncased' \
    --note random0,seed$id,aggr,fewshot\
    --ntasks 4 \
    --nclasses 5 \
    --task vlcs \
    --scenario dil_classification \
    --idrandom 0 \
    --approach cnn_mtl \
    --eval_batch_size 128 \
    --train_batch_size 128 \
    --image_size 32 \
    --image_channel 3 \
    --nepochs 100 \
    --seed $id \
    --mtl\
    --fewshot \
    --each_class_remain_sample 1
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
