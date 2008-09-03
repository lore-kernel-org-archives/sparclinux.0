From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Wed, 03 Sep 2008 16:32:32 +0000
Subject: [PATHC 0/2] sparc32: convert to RTC subsystem
Message-Id: <20080903183232.b57f5a05.krzysztof.h1@wp.pl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

This is my clumsy attempt to convert the sparc32
to the RTC subsystem.
These patches require two patches from the -mm tree:

rtc-m48t59-reduce-structure-m48t59_private.patch
rtc-m48t59-add-support-for-m48t02-and-m48t59-chips-2nd-rev.patch

The driver was tested on SS20.

Robert, please test it on as many machine as you can.

Kind regards,
Krzysztof
