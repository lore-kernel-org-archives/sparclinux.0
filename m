From: Michael Tautschnig <michael.tautschnig@zt-consulting.com>
Date: Mon, 14 Feb 2005 16:34:30 +0000
Subject: Re: size-differences of long(userspace) / long(kernel)
Message-Id: <Pine.LNX.4.61.0502141730570.6890@l01.thnet>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0502141648360.6890@l01.thnet>
In-Reply-To: <Pine.LNX.4.61.0502141648360.6890@l01.thnet>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>
> See arch/sparc64/kernel/ioctl32.c, we translate all of the
> structures on the way in and out of userspace when 64-bit
> kernel runs 32-bit applications.
>
Hmm - I don't really get the point - would you mind explaining a little?

Is it the following lines or did I overlook anything:

#define COMPATIBLE_IOCTL(cmd)   HANDLE_IOCTL((cmd),sys_ioctl)
#define HANDLE_IOCTL(cmd,handler) { (cmd), (ioctl32_handler_t)(handler), 
NULL },
#define IOCTL_TABLE_START \
   struct ioctl_trans ioctl_start[] = {
#define IOCTL_TABLE_END \
   };

and the following table generated using these defines?

Thanks,
Michael
