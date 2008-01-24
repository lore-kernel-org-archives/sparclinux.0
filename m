From: Jan Engelhardt <jengelh@computergmbh.de>
Date: Thu, 24 Jan 2008 11:49:28 +0000
Subject: Re: Please build test your changes.
Message-Id: <Pine.LNX.4.64.0801241247590.12676@fbirervta.pbzchgretzou.qr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org


On Jan 23 2008 21:30, David Miller wrote:
>
>Sorry Jan I have to revert your change:
>
>[SPARC]: Constify function pointer tables.
>
>Signed-off-by: Jan Engelhardt <jengelh@computergmbh.de>
>Signed-off-by: David S. Miller <davem@davemloft.net>
>
>arch/sparc64/solaris/socksys.c: In function ‘init_socksys’:
>arch/sparc64/solaris/socksys.c:192: error: assignment of read-only variable ‘socksys_file_ops’
>arch/sparc64/solaris/socksys.c:195: error: assignment of read-only variable ‘socksys_file_ops’
>arch/sparc64/solaris/socksys.c:196: error: assignment of read-only variable ‘socksys_file_ops’
>
I am sorry about that, I did not have a sparc64 crosscompiler nor native
compiler at hand. As it seems, only the socksys_file_ops hunk needs
to be reversed.
Thanks!
Jan

