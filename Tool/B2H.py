def binary_to_hex(input_file, output_file):
    # 打开输入文件和输出文件
    with open(input_file, 'r') as infile, open(output_file, 'w') as outfile:
        # 逐行读取输入文件
        for line in infile:
            # 去除换行符和空白字符，并确保行不是空的
            binary_data = line.strip()
            if binary_data:
                # 将二进制转换为十六进制并写入输出文件
                hex_value = f'{int(binary_data, 2):02x}'
                outfile.write(hex_value + '\n')
    print(f"十六进制数据已成功逐行写入到 {output_file} 文件中。")

# 调用函数示例
binary_to_hex('init_memb', 'output')
