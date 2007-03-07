From: David Miller <davem@davemloft.net>
Date: Wed, 07 Mar 2007 22:51:32 +0000
Subject: Re: Sunfire v880
Message-Id: <20070307.145132.21926882.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <a728f9f90703061649i63c845a3o593040df1cd0760f@mail.gmail.com>
In-Reply-To: <a728f9f90703061649i63c845a3o593040df1cd0760f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Alex Deucher" <alexdeucher@gmail.com>
Date: Wed, 7 Mar 2007 17:48:22 -0500

> I know how to build the kernel, I just wasn't sure if anything special
> was required to create an image that OBP could boot via the network.

I thought you had a successful network install using gentoo and
therefore could build a kernel on the machine itself?

In any event, if you need to netboot, you can do
"make vmlinux.aout" and the resulting arch/sparc64/boot/vmlinux.aout
file can be netbooted.
