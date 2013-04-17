From: Greg KH <gregkh@linuxfoundation.org>
Date: Wed, 17 Apr 2013 00:56:53 +0000
Subject: Re: [PATCH 01/28] Include missing linux/slab.h inclusions [RFC]
Message-Id: <20130417005653.GA11541@kroah.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20130416182550.27773.89310.stgit@warthog.procyon.org.uk>
 <20130416182554.27773.86004.stgit@warthog.procyon.org.uk>
In-Reply-To: <20130416182554.27773.86004.stgit-S6HVgzuS8uM4Awkfq6JHfwNdhmdF6hFW@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-efi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, Apr 16, 2013 at 07:25:54PM +0100, David Howells wrote:
> Include missing linux/slab.h inclusions where the source file is currently
> expecting to get kmalloc() and co. through linux/proc_fs.h.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-s390@vger.kernel.org
> cc: sparclinux@vger.kernel.org
> cc: linux-efi@vger.kernel.org
> cc: linux-mtd@lists.infradead.org
> cc: devel@driverdev.osuosl.org
> cc: x86@kernel.org
> ---
>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
