From: Josip Rodin <joy@entuzijast.net>
Date: Sat, 01 Jan 2011 21:45:52 +0000
Subject: Re: [PATCH 7/9] sparc: use piggyback_32 for sparc64
Message-Id: <20110101214552.GA29738@entuzijast.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1293915632-4596-7-git-send-email-sam@ravnborg.org>
In-Reply-To: <1293915632-4596-7-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Jan 01, 2011 at 10:00:30PM +0100, Sam Ravnborg wrote:
> diff --git a/arch/sparc/boot/piggyback_64.c b/arch/sparc/boot/piggyback_64.c
> deleted file mode 100644
> index a26a686..0000000
> --- a/arch/sparc/boot/piggyback_64.c
> +++ /dev/null
> @@ -1,110 +0,0 @@
> -/*
> -   Simple utility to make a single-image install kernel with initial ramdisk
> -   for Sparc64 tftpbooting without need to set up nfs.
> -   
> -   Copyright (C) 1997 Jakub Jelinek (jj@sunsite.mff.cuni.cz)

Presumably you copied all that code from this file, so you should also
move over the copyright statement (the year in the other one differs).

-- 
     2. That which causes joy or happiness.
