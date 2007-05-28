From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Date: Mon, 28 May 2007 09:49:21 +0000
Subject: Re: SILO MMU Miss problem located
Message-Id: <Pine.LNX.4.61.0705281148390.11140@yvahk01.tjqt.qr>
List-Id: <sparclinux.vger.kernel.org>
References: <200705280133.l4S1XfE5028506@sunsmoke.org>
In-Reply-To: <200705280133.l4S1XfE5028506@sunsmoke.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


On May 27 2007 21:33, gregsparc@sunsmoke.org wrote:
>
>.../silo-1.4.13/second/main.c:1485
>	int len = *(unsigned int *)kernel_params;
>
>This line never completes. 
>
>If anyone knows more about this or has a patch they'd like me to try,
>please let me know. It's probably not helpful, but my guess is that there's
>some kind of alignment problem.

If you suspect an alignment problem do

	printf("kernel_params=%p\n", kernel_params);

(or whatever is needed to get it printed) and see if it does
divide cleanly by 4.



	Jan
-- 
