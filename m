From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Sat, 28 Jul 2007 22:38:55 +0000
Subject: Re: Sparc32 not working:2.6.23-rc1 (git commit
Message-Id: <20070729003855.1c5422ed.krzysztof.h1@wp.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0707281903350.27869@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0707281903350.27869@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, 28 Jul 2007 23:48:56 +0200
Krzysztof Helt <krzysztof.h1@wp.pl> wrote:


> 
> I have just booted the 2.6.32-rc1-git4 (which differs from yours by only 3 IA64 patches) on SS20 
> with UP kernel and Aurora 3. The SMP kernel boots but it crashes when storage is
> initialized (I try tracking this down).
> 

Update: this is not storage, but sunlance.ko module. Loading this module ends with message:

Unable to handle kernel paging request at virtual address ef7dc000

and more messages about MMU until the linux hangs.

I have the second lance chip on the SBUS 10Mbit + SCSI card (I don't know the name). I'll do more tests tomorrow.

Regards,
Krzysztof
PS. Everything works ok with UP kernel.
