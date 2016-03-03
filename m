From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 03 Mar 2016 07:43:16 +0000
Subject: Re: Kernels 4.+ are breaking rsync?
Message-Id: <875444B2-989A-4ACD-9A16-05AAD984C165@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <56C11585.3060503@triadic.us>
In-Reply-To: <56C11585.3060503@triadic.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



> On Mar 3, 2016, at 3:03 PM, Alex McWhirter <alexmcwhirter@triadic.us> wrote:
> 
> I'm currently building the sparc64 port, but this is one of the final
> few things that needs addressed before i release the patches.

I see. Didn't know there was any sparc64 work besides Linux for SPARC and Debian.

> This bug
> seems to only surface itself when attempting to sync a very large file
> structure. The Gentoo portage tree is a good example.

Define large.

> Would you mind trying to rsync this?
> "rsync://rsync.us.gentoo.org/gentoo-portage/".

I did a quick "rsync -avz rsync://rsync.us.gentoo.org/gentoo-portage/x11-apps gentoo/" and that worked.

But again, I haven't seen any rsync-related crashes on sparc64 at all.

Adrian
