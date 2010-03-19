From: "H. Peter Anvin" <hpa@zytor.com>
Date: Fri, 19 Mar 2010 23:55:26 +0000
Subject: Re: [klibc] klibc sparc sockets foo
Message-Id: <4BA40EEE.6000401@zytor.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20100314161159.GA23007@stro.at>
In-Reply-To: <20100314161159.GA23007@stro.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 03/14/2010 03:45 PM, David Miller wrote:
> 
> So probably the best thing to do is, like the commit presented
> at the top of this thread, use sys_socketcall unconditionally.
> From some simple tests this is what glibc does too.
> 

It's worth noting that if the syscall number macros for unimplemented
system calls are removed, then klibc will automatically use socketcall
for the remaining calls.  It is always a major headache when an
architecture breaks automation by advertising a system call and then not
actually implementing it.

	-hpa
