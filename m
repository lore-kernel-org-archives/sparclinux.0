From: Raymond Burns <rayburns@comcast.net>
Date: Wed, 19 Jul 2006 16:36:27 +0000
Subject: Re: sparc32 git tree
Message-Id: <Pine.LNX.4.10.10607181432210.10727-100000@coalcreekmill.cm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <44BBB08C.3090004@mc.net>
In-Reply-To: <44BBB08C.3090004@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi

zs_get_instance returns a value 0 or 1 . zs occurance greater then
that never get structure initialized.

What I did was set up->port.membase to null in sunzilog_alloc_tables
then a for loop to pick next available in zs_get_instance.

A simple init space global counter would work as well

The next stumble originated in sunzilog_init, accounting for mouse and
keyboard left the uart_count 2 short of the number of serial ports.


my tree's a mess


Thanx
  Ray



