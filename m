From: David Miller <davem@davemloft.net>
Date: Thu, 02 Jun 2011 21:27:59 +0000
Subject: Re: mmap operation not working as expected on sparc linux
Message-Id: <20110602.142759.545467293328553082.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4DE5F5B9.4020601@redhat.com>
In-Reply-To: <4DE5F5B9.4020601@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Steven Dake <sdake@redhat.com>
Date: Wed, 01 Jun 2011 02:37:04 -0700

> Thanks for the response.  For those searching for this problem in the
> future, We tried 16384, and then decided to have a look at the kernel
> source tree and came up with some speculation that the hugetlb settings
> would result in EINVAL via prepare_hugetlb.  The minimum page we could
> execute this operation on was 4MB.  I notice on some other arches this
> is not required.

Requiring 4MB is not kosher, it shouldn't be asking you to do that
much.

Where is this prepare_hugetlb() function in the kernel?  I cannot
find it.

Also, please prepare a test case for me, I want to fix this.

Thanks.
