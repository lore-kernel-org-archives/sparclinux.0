From: Kirill Tkhai <tkhai@yandex.ru>
Date: Sat, 17 Aug 2013 00:52:22 +0000
Subject: [sparc64] Question about loop interations in trampoline_64.S
Message-Id: <1211376700742@web12h.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi!

%l5 iterates from 0 to %l6, where %l6 is (num_kernel_image_mappings + 1).

The loop is equal to:

for (l5 = 0; l5 < num_kernel_image_mappings + 1; l5++).

Is there no error? Looks like we don't have to lock 4MB page, which  number
is num_kernel_image_mappings. Or prom call has any side effect?

Regards,
Kirill
