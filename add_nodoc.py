#!/usr/bin/env python3
import os
import glob

def add_nodoc_to_file(file_path):
    """为单个文件添加 @nodoc 注释"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # 检查是否已经有 @nodoc 注释
        if '@nodoc' in content:
            print(f"File {file_path} already has @nodoc, skipping...")
            return
        
        lines = content.split('\n')
        
        # 如果第一行是 library 声明，在第二行添加 @nodoc
        if lines[0].strip().startswith('library'):
            lines.insert(1, '@nodoc')
        else:
            # 否则在第一行添加 @nodoc
            lines.insert(0, '@nodoc')
        
        new_content = '\n'.join(lines)
        
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(new_content)
        
        print(f"Added @nodoc to {file_path}")
        
    except Exception as e:
        print(f"Error processing {file_path}: {e}")

def main():
    # 获取所有 Dart 文件
    dart_files = glob.glob('lib/pages/**/*.dart', recursive=True)
    
    print(f"Found {len(dart_files)} Dart files to process")
    
    for file_path in dart_files:
        add_nodoc_to_file(file_path)
    
    print("All files processed!")

if __name__ == "__main__":
    main()


