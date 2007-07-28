From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Sat, 28 Jul 2007 23:21:06 +0000
Subject: Re: Sparc32 not working:2.6.23-rc1 (git commit
Message-Id: <Pine.LNX.4.61.0707290011300.28457@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0707281903350.27869@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0707281903350.27869@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Krzysztof,

There have been lots of changes to the DMA system (git bisect is not 
viable form my working 2.6.22 kernel as the dma changes kill the build for 
over half the posible commits to check). It could be a side effect of 
these changes.

For me, a non-functional lance is a show stopper as my kernels are all 
tested using an NFS root. No network means no root ... :(

I am setting up an ext2 partition at the moment. It should alow me do some 
testing without any network but it will be a dificult setup to test as I 
have not tries running up an nfs server on my linux-sparc setup yet so 
getting the files setup will take several reboots to different OS/OS 
Versions.

Regards
 	Mark Fortescue.

On Sun, 29 Jul 2007, Krzysztof Helt wrote:

> On Sat, 28 Jul 2007 23:48:56 +0200
> Krzysztof Helt <krzysztof.h1@wp.pl> wrote:
>
>
>>
>> I have just booted the 2.6.32-rc1-git4 (which differs from yours by only 3 IA64 patches) on SS20
>> with UP kernel and Aurora 3. The SMP kernel boots but it crashes when storage is
>> initialized (I try tracking this down).
>>
>
> Update: this is not storage, but sunlance.ko module. Loading this module ends with message:
>
> Unable to handle kernel paging request at virtual address ef7dc000
>
> and more messages about MMU until the linux hangs.
>
> I have the second lance chip on the SBUS 10Mbit + SCSI card (I don't know the name). I'll do more tests tomorrow.
>
> Regards,
> Krzysztof
> PS. Everything works ok with UP kernel.
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
