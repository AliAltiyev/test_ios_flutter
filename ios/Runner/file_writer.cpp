#include "file_writer.h"
#include <fstream>
#include <string>

extern "C" {
    int write_to_file(const char* file_path, const char* content) {
        if (file_path == nullptr || content == nullptr) {
            return FILE_WRITE_INVALID_PARAMS;
        }
        
        try {
            std::ofstream file(file_path, std::ios::app);
            
            if (!file.is_open()) {
                return FILE_WRITE_OPEN_ERROR;
            }
            
            file << content << std::endl;
            
            return FILE_WRITE_SUCCESS;
        } catch (...) {
            return FILE_WRITE_EXCEPTION;
        }
    }
}

