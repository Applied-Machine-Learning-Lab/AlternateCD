PRE_SEQ_LEN=128
CHECKPOINT="./experiments/outputs/IMCS-V2-SR-chatglm-6b-pt-128-2e-2"   # 填入用来存储模型的文件夹路径
STEP=100    # 用来评估的模型checkpoint是训练了多少步

your_data_path="./datasets/PromptCBLUE/IMCS-V2-SR"  # 填入数据集所在的文件夹路径
model_name_or_path="/data2/derongxu/tencent_code/LLM_checkpoint/chatglm-6b"   # LLM底座模型路径，或者是huggingface hub上的模型名称


CUDA_VISIBLE_DEVICES=1 python src/ft_chatglm_ptuning/main.py \
    --do_predict \
    --do_eval \
    --validation_file $your_data_path/dev.json \
    --test_file $your_data_path/test.json \
    --overwrite_cache \
    --prompt_column input \
    --response_column target \
    --model_name_or_path $model_name_or_path \
    --ptuning_checkpoint $CHECKPOINT/checkpoint-$STEP \
    --output_dir $CHECKPOINT \
    --overwrite_output_dir \
    --max_source_length 700 \
    --max_target_length 196 \
    --per_device_eval_batch_size 1 \
    --predict_with_generate \
    --pre_seq_len $PRE_SEQ_LEN
