From: Anatoly Pugachev <matorola@gmail.com>
Date: Wed, 04 Apr 2018 13:33:27 +0000
Subject: [sparc64] number of processors in a LDOM
Message-Id: <CADxRZqxtUNueaC70=g4-Gyo+mO8dtTTmWh3DU8MgEiSH3vtW1Q@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernelnewbies@lists.kernelnewbies.org

Hello!

Can someone tell me or suggest why does getconf returns total available to
a physical machine cpu count, and not LDOM allocated processor/vcpu count ?

ttip$ getconf -a | grep PROCESSORS
_NPROCESSORS_CONF                  256
_NPROCESSORS_ONLN                  16

i believe, nproc (from coreutils) use getconf as well :

ttip$ nproc --all
256

ttip$ nproc
16

But this LDOM is defined as following (16 vcpus allocated):

# ldm list
NAME             STATE      FLAGS   CONS    VCPU  MEMORY   UTIL  NORM
UPTIME
ttip             active     -n----  5004    16    32G      0.0%  0.0%  3h 1m


Just to compare, if we take power systems (ppc64) LPAR, it reports only
LPAR allocated CPU count (not physical machine available cpu/core count).

I'm raising this issue, because some userspace tools use nproc to run
parallel make for example. And starting from 4.15+ (but not on 4.14) kernel
overcommited CPU usage (for example, using make -j256 on a LDOM with 16
vcpus allocated) gets me to the following (reproducible):

Message from syslogd@ttip at Apr  3 14:53:15 ...
 kernel:[  942.850499] BUG: workqueue lockup - pool cpus=8 node=0
flags=0x0 nice=0 stuck for 36s!
Apr 03 14:53:15 ttip kernel: BUG: workqueue lockup - pool cpus=8
node=0 flags=0x0 nice=0 stuck for 36s!
Apr 03 14:53:15 ttip kernel: Showing busy workqueues and worker pools:
Apr 03 14:53:15 ttip kernel: workqueue mm_percpu_wq: flags=0x8
Apr 03 14:53:15 ttip kernel:   pwq 16: cpus=8 node=0 flags=0x0 nice=0
active=1/256
Apr 03 14:53:15 ttip kernel:     pending: vmstat_update
Apr 03 14:53:15 ttip kernel: workqueue xfs-sync/dm-0: flags=0x4
Apr 03 14:53:15 ttip kernel:   pwq 0: cpus=0 node=0 flags=0x0 nice=0
active=1/256
Apr 03 14:53:15 ttip kernel:     pending: xfs_log_worker [xfs]
^C
Message from syslogd@ttip at Apr  3 14:53:45 ...
 kernel:[  972.929725] BUG: workqueue lockup - pool cpus=8 node=0
flags=0x0 nice=0 stuck for 66s!

Message from syslogd@ttip at Apr  3 14:54:15 ...
 kernel:[ 1003.008979] BUG: workqueue lockup - pool cpus=8 node=0
flags=0x0 nice=0 stuck for 96s!

Message from syslogd@ttip at Apr  3 14:54:46 ...
 kernel:[ 1033.088189] BUG: workqueue lockup - pool cpus=8 node=0
flags=0x0 nice=0 stuck for 126s!

Message from syslogd@ttip at Apr  3 14:55:16 ...
 kernel:[ 1063.166574] BUG: workqueue lockup - pool cpus=8 node=0
flags=0x0 nice=0 stuck for 156s!

Message from syslogd@ttip at Apr  3 14:55:46 ...
 kernel:[ 1093.244982] BUG: workqueue lockup - pool cpus=8 node=0
flags=0x0 nice=0 stuck for 186s!

This messages occasionally lead to machine/LDOM being unstable, i.e.
with some lockups to processes.

filtered dmesg output:

ttip$ dmesg  | egrep -i "cpu|smp"
[    0.000073] Linux version 4.16.0-05456-g17dec0a94915 (mator@ttip)
(gcc version 7.3.0 (Debian 7.3.0-14)) #659 SMP Wed Apr 4 12:16:32 MSK
2018
[    0.037199] PLATFORM: max-cpus [1024]
[    0.194415] CPU CAPS: [flush,stbar,swap,muldiv,v9,blkinit,n2,mul32]
[    0.194525] CPU CAPS: [div32,v8plus,popc,vis,vis2,ASIBlkInit,fmaf,vis3]
[    0.194630] CPU CAPS: [hpc,ima,pause,cbcond,aes,des,kasumi,camellia]
[    0.194731] CPU CAPS: [md5,sha1,sha256,sha512,mpmul,montmul,montsqr,crc32c]
[    0.237948] percpu: Embedded 12 pages/cpu @        (ptrval) s56584
r8192 d33528 u131072
[    0.238199] pcpu-alloc: s56584 r8192 d33528 u131072 alloc=1*4194304
[    0.238209] pcpu-alloc: [0] 000 001 002 003 004 005 006 007 008 009
010 011 012 013 014 015 016 017 018 019 020 021 022 023 024 025 026
027 028 029
030 031
[    0.238363] pcpu-alloc: [0] 032 033 034 035 036 037 038 039 040 041
042 043 044 045 046 047 048 049 050 051 052 053 054 055 056 057 058
059 060 061
062 063
[    0.238515] pcpu-alloc: [0] 064 065 066 067 068 069 070 071 072 073
074 075 076 077 078 079 080 081 082 083 084 085 086 087 088 089 090
091 092 093
094 095
[    0.238668] pcpu-alloc: [0] 096 097 098 099 100 101 102 103 104 105
106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122
123 124 125
126 127
[    0.238820] pcpu-alloc: [0] 128 129 130 131 132 133 134 135 136 137
138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154
155 156 157
158 159
[    0.238973] pcpu-alloc: [0] 160 161 162 163 164 165 166 167 168 169
170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186
187 188 189
190 191
[    0.239125] pcpu-alloc: [0] 192 193 194 195 196 197 198 199 200 201
202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218
219 220 221
222 223
[    0.239278] pcpu-alloc: [0] 224 225 226 227 228 229 230 231 232 233
234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250
251 252 253
254 255
[    0.239873] SUN4V: Mondo queue sizes [cpu(131072) dev(16384) r(8192) nr(256)]
[    0.242373] log_buf_len individual max cpu contribution: 4096 bytes
[    0.242438] log_buf_len total cpu_extra contributions: 1044480 bytes
[    0.516414] smp: Bringing up secondary CPUs ...
[    0.548006] smp: Brought up 1 node, 16 CPUs
