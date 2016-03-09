From: alexmcwhirter@triadic.us
Date: Wed, 09 Mar 2016 22:10:59 +0000
Subject: Re: Kernels 4.+ are breaking =?UTF-8?Q?rsync=3F?=
Message-Id: <581ea36a631e99ef3f7a2bf4d03617e4@triadic.us>
List-Id: <sparclinux.vger.kernel.org>
References: <e27cb22ab17f1f6e5b795c55b90daa01@triadic.us>
In-Reply-To: <e27cb22ab17f1f6e5b795c55b90daa01@triadic.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 2016-03-07 22:28, Alex McWhirter wrote:
> On 03/04/2016 04:41 PM, John Paul Adrian Glaubitz wrote:
>> On 03/05/2016 06:21 AM, alexmcwhirter@triadic.us wrote:
>>> Anyways, im giving Debian a shot now. The installer refused to format 
>>> my
>>> boot partition as ext2, so i had to use ext3. That probably a little 
>>> off
>>> topic though, so ill keep you updated on my findings.
>> Great!
>> 
>> Please report issue with the installer on Debian sparc64 to the
>> debian-sparc mailing list:
>> 
>>> https://lists.debian.org/debian-sparc/
> 
> I can confirm that this issue appears on my Sun Fire V215, but not my
> SPARC Enterprise T5120. I suppose i need to do a bit more digging.
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" 
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Ok, so bit more info. This only seems to effect local disk transfers, 
not server -> client transfers. I can verify this behaviour on Debian 
and Gentoo, as well as on a Sun Fire V215 and Sun Blade 150.

Steps to reproduce.

rysnc -a rsync://rsync.ca.gentoo.org/gentoo-portage/ ~/portage
rsync -a ~/portage ~/portage2

You should see something around these lines occur...

rsync: [sender] write error: Broken pipe (32)
rsync error: error in socket IO (code 10) at io.c(820) [sender=3.1.1]


If you don't want to download the whole portage tree, you can probably 
get away with a large subdirectory like x11-libs.

I.E.

rysnc -a rsync://rsync.ca.gentoo.org/gentoo-portage/x11-libs ~/x11-libs
rsync -a ~/x11-libs ~/x11-libs2

As stated earlier, using git bisect to eventually roll back commit 
e5a4b0bb803b39a36478451eae53a880d2663d5b will resolve the problem.
