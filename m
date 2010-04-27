From: David Miller <davem@davemloft.net>
Date: Tue, 27 Apr 2010 18:47:29 +0000
Subject: Re: [PATCH] Disable execmem for sparc
Message-Id: <20100427.114729.42800279.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4BAA89B9.2030102@redhat.com>
In-Reply-To: <4BAA89B9.2030102@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Tue, 27 Apr 2010 14:20:21 -0400

> [root@apollo ~]$ cat /proc/2174/maps
> 00010000-00014000 r-xp 00000000 fd:00 15466577
>  /sbin/mingetty
> 00022000-00024000 rwxp 00002000 fd:00 15466577
>  /sbin/mingetty
> 00024000-00046000 rwxp 00000000 00:00 0
>  [heap]

SELINUX probably barfs on the executable heap, the PLT is in the HEAP
just like powerpc32 and that's why VM_DATA_DEFAULT_FLAGS has to set
both executable and writable.

You also can't remove the CONFIG_PPC32 ifdefs in selinux, since
because of the VM_DATA_DEFAULT_FLAGS setting used still in that arch,
the heap will always have executable permission, just like sparc does.
You have to support those binaries forever, whether you like it or not.

Let's just replace the CONFIG_PPC32 ifdef in SELINUX with CONFIG_PPC32
|| CONFIG_SPARC as in Tom's original patch and let's be done with
this.

In fact I would go through all the arch/ header files and check the
VM_DATA_DEFAULT_FLAGS settings and add the necessary new ifdefs to the
SELINUX code so that other platforms don't have the pain of having to
go through this process too.

Thanks.
