From: Alex McWhirter <alexmcwhirter@triadic.us>
Date: Thu, 03 Mar 2016 07:03:04 +0000
Subject: Re: Kernels 4.+ are breaking rsync?
Message-Id: <56D7E1A8.1050009@triadic.us>
List-Id: <sparclinux.vger.kernel.org>
References: <56C11585.3060503@triadic.us>
In-Reply-To: <56C11585.3060503@triadic.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 03/03/2016 01:57 AM, John Paul Adrian Glaubitz wrote:
> On Mar 3, 2016, at 2:50 PM, Alex McWhirter <alexmcwhirter@triadic.us> wrote:
>>> On 03/03/2016 01:50 AM, John Paul Adrian Glaubitz wrote:
>>>> On Mar 3, 2016, at 2:31 PM, Alex McWhirter <alexmcwhirter@triadic.us> wrote:
>>>> Also you should be able to reproduce it on any sun4u hardware, as it
>>>> occurs on all of my boxes. Sun4v may paint a different picture.
>>> What distribution is this? I haven't seen any rsync crashes on my Sun Blade 100 which is also a sun4u [1].
>>>
>>> I'm running Debian's sparc64 port. Recent install images can be found in [2].
>>>
>>> Adrian
>>>
>>>> [1] https://docs.oracle.com/cd/E19683-01/819-2946/estar.html
>>>> [2] https://people.debian.org/~glaubitz/debian-cd/
>> Gentoo, are you using kernel 3.19.0+?
> Well, as I said, those are _current_ images. Kernel is 4.4.x with all packages up to date and a complete 64-bit (v9) userland. Can't get any more recent.
>
> Isn't Gentoo on SPARC 32-bit (v8+) userland anyway?
>
> Adrian

I'm currently building the sparc64 port, but this is one of the final
few things that needs addressed before i release the patches. This bug
seems to only surface itself when attempting to sync a very large file
structure. The Gentoo portage tree is a good example.

Would you mind trying to rsync this?
"rsync://rsync.us.gentoo.org/gentoo-portage/".
