From: David Miller <davem@davemloft.net>
Date: Tue, 19 Sep 2017 20:40:38 +0000
Subject: Re: [PATCH] Expose some h/w info from ILOM to userspace via sysfs
Message-Id: <20170919.134038.855876532081330031.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <baf0b81a-0265-ed20-52c8-e5c558f62c47@oracle.com>
In-Reply-To: <baf0b81a-0265-ed20-52c8-e5c558f62c47@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Eric Saint Etienne <eric.saint.etienne@oracle.com>
Date: Tue, 19 Sep 2017 20:09:57 +0100

> Can you please have a look to the ilom patch
> (arch/sparc/kernel/ilom.c) then please? If you can't find it then
> let me know and I'll resend it.

Ok, I guess that is alright.  But it needs a bunch of changes.

Don't use uint_8_t etc. in the kernel, use u8 et al. instead.

Do not use the __packed attribute unless absolutely necessary
which seems entirely not the case for sunoem_cli_msg.

Please remove the ILOM_PROFILING, you can achieve the same effect
with tracepoints and perf.

Looking at the driver from a high level, it just seems to export
a seemingly arbitrary set of ILOM properties.  Why not provide
a real hierarchy of all the /SYS, /HOST, etc. stuff via /sysfs?

The string parsing and matching in there is exactly the kind of
code I'm talking about which doesn't belong in the kernel.

The kernel should export a family of values for whatever (bus,
firmware settings, etc.) transparently to the user and let them
do whatever they want with whichever values they find interesting.

It is not the kernel's business to filter, not interpret, the
objects.  Yet that is what these drivers are doing.
