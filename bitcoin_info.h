#ifndef BITCOIN_INFO_H
#define BITCOIN_INFO_H

#include <stddef.h>

int fetch_bitcoin_info(double *bitcoin_price, int *block_height, char *timestamp, size_t timestamp_size);

#endif
