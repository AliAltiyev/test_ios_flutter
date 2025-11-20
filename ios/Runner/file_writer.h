#ifndef FILE_WRITER_H
#define FILE_WRITER_H

#ifdef __cplusplus
extern "C" {
#endif

enum FileWriteResult {
    FILE_WRITE_SUCCESS = 0,
    FILE_WRITE_INVALID_PARAMS = -1,
    FILE_WRITE_OPEN_ERROR = -2,
    FILE_WRITE_EXCEPTION = -3
};

int write_to_file(const char* file_path, const char* content);

#ifdef __cplusplus
}
#endif

#endif

