From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Date: Wed, 21 Dec 2016 21:18:39 +0000
Subject: Re: [PATCH] sparc: Fail userspace mmap for disabled PCI I/O and MEM BARs.
Message-Id: <20161221211838.dhwblyopimzbvk5y@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1482345818-6073-1-git-send-email-Liam.Howlett@Oracle.com>
In-Reply-To: <1482345818-6073-1-git-send-email-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

* David Miller <davem@davemloft.net> [161221 14:13]:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> Date: Wed, 21 Dec 2016 13:43:38 -0500
> 
> > Check if the PCI memory starting address is disabled and return -EINVAL.
> > This will have minimal impact to performance as it is only during the
> > set up of the mmap and will avoid consequences of a failed load/store.
> > 
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> 
> Some X server or similar userland application may be depending upon
> the current behavior.
> 
> I'd rather not check, and let the user take the SIGBUS if it tries
> to access it.
> 
> Furthermore, the user can legitimately map a disabled BAR then enable
> it with PCI config accesses.
> 
> So I'm not applying this, sorry.


I appreciate you taking the time to tell me how this patch is not the
right way to fix this issue.  I will rework my solution to this issue to
behave in a more appropriate manner.

I should have mentioned that this patch isn't to remap a SIGBUS to an
-EINVAL, it's to stop the system from a panic due to a non-recoverable
error occurring when trying to read an mmap'ed resource that is not
enabled.

Thank you,
Liam
