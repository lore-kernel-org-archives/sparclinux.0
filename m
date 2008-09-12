From: Elad Lahav <elahav@uwaterloo.ca>
Date: Fri, 12 Sep 2008 21:10:50 +0000
Subject: Processor IDs on the Niagara
Message-Id: <48CADADA.7050604@uwaterloo.ca>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I have a question regarding the meaning of cpu_data.proc_id.
My T1000 contains a single T1 processor, with 8 cores and 4 threads per core. The core_id 
value for each hardware thread is set up properly (though starting from 1 rather than 0). 
The proc_id value, however, does not make sense: it maps to core_id - 1. I would have 
expected one of two values:
1. The virtual processor ID, as described in the Machine Description block ("cpu"->"id");
2. A physical processor ID, shared by all 32 threads (and differs among chips on the T2+).
While the former is probably the same as the kernel's CPU id, the latter, so I believe, 
should be part of cpu_data.

A side effect of this issue is that cpu_sibling_map and cpu_core_map are the same (though 
this may be the expected result, I'm not sure).

Here are the per-virtual-processor values on my machine. The format is
CPUID proc_id core_id (sibling map) (core map)

00 00 01 (00,01,02,03) (00,01,02,03)
01 00 01 (00,01,02,03) (00,01,02,03)
02 00 01 (00,01,02,03) (00,01,02,03)
03 00 01 (00,01,02,03) (00,01,02,03)
04 01 02 (04,05,06,07) (04,05,06,07)
05 01 02 (04,05,06,07) (04,05,06,07)
06 01 02 (04,05,06,07) (04,05,06,07)
07 01 02 (04,05,06,07) (04,05,06,07)
08 02 03 (08,09,10,11) (08,09,10,11)
09 02 03 (08,09,10,11) (08,09,10,11)
10 02 03 (08,09,10,11) (08,09,10,11)
11 02 03 (08,09,10,11) (08,09,10,11)
12 03 04 (12,13,14,15) (12,13,14,15)
13 03 04 (12,13,14,15) (12,13,14,15)
14 03 04 (12,13,14,15) (12,13,14,15)
15 03 04 (12,13,14,15) (12,13,14,15)
16 04 05 (16,17,18,19) (16,17,18,19)
17 04 05 (16,17,18,19) (16,17,18,19)
18 04 05 (16,17,18,19) (16,17,18,19)
19 04 05 (16,17,18,19) (16,17,18,19)
20 05 06 (20,21,22,23) (20,21,22,23)
21 05 06 (20,21,22,23) (20,21,22,23)
22 05 06 (20,21,22,23) (20,21,22,23)
23 05 06 (20,21,22,23) (20,21,22,23)
24 06 07 (24,25,26,27) (24,25,26,27)
25 06 07 (24,25,26,27) (24,25,26,27)
26 06 07 (24,25,26,27) (24,25,26,27)
27 06 07 (24,25,26,27) (24,25,26,27)
28 07 08 (28,29,30,31) (28,29,30,31)
29 07 08 (28,29,30,31) (28,29,30,31)
30 07 08 (28,29,30,31) (28,29,30,31)
31 07 08 (28,29,30,31) (28,29,30,31)

Elad
