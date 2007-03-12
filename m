From: David Miller <davem@davemloft.net>
Date: Mon, 12 Mar 2007 20:40:28 +0000
Subject: Re: libhugetlbfs and sparc64 support
Message-Id: <20070312.134028.92584603.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070312183920.GD29949@us.ibm.com>
In-Reply-To: <20070312183920.GD29949@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Nishanth Aravamudan <nacc@us.ibm.com>
Date: Mon, 12 Mar 2007 11:39:20 -0700

> ***********************
> Warning: Your file, libhugetlbfs-sparc64.tar.bz2, contains more than 32 files after decompression and cannot be scanned.
> ***********************

What is it with these extremely stupid email virus scanners, this thing
checks on outgoing emails too?!?!?!

> I'm currently trying to add (basic) support for sparc64 to libhugetlbfs.
> If nothing else, this will ensure that sparc64 gets adequate testing. I
> am finding, though, that using the attached tarball and running `make
> func`, which should run through a series of quick functional tests, an
> Ultra 60 I have access to hangs hard. To be clear, I'm not ruling out
> general instability, but same box is able to build kernels and I'm more
> prone to suspect hugepage support in the kernel.

I'll try to take a look at this, thanks.
