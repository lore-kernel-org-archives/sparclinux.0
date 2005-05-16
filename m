From: Bob Breuer <breuerr@mc.net>
Date: Mon, 16 May 2005 15:37:12 +0000
Subject: Re: sparc32 2.6 work
Message-Id: <4288BE28.3050801@mc.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4285EE7A.7090200@bellsouth.net>
In-Reply-To: <4285EE7A.7090200@bellsouth.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Jurij Smakov wrote:
> 
> Well, UP in Debian is pretty solid on sparc32. I happen to own one of 
> the machines with Hypersparc CPU and UP 2.6.x and Debian's pre-built 
> kernels are stable enough to build other packages and kernels on it. The 
> only sparc32 patch we are applying against 2.6.11 is the following:
> 
> --- kernel-source-2.6.11-2.6.11-orig//arch/sparc/mm/srmmu.c    
> 2005-03-02 08:38:10.000000000 +0100
> +++ kernel-source-2.6.11-2.6.11/arch/sparc/mm/srmmu.c    2005-03-05 
> 10:39:38.677679448 +0100
> @@ -1464,7 +1464,6 @@
>  static void __init init_hypersparc(void)
>  {
>          srmmu_name = "ROSS HyperSparc";
> -    srmmu_modtype = HyperSparc;
> 
>          init_vac_layout();
> 
> Without it the kernel fails to mount initrd on boot due to unknown 
> reason. This change was discovered after numerous experiments :-). The 
> only other quirk I know (which can be related) is that Debian's 2.6.8 
> netboot images do not boot Hypersparc machines (others seem to be fine), 
> again due to the trouble with initrd.
> 

Reverting that change should not be needed for 2.6.11 (but it did cause 
other problems with 2.6.10).  Mounting an initrd under 2.6.11 works for 
me on my hypersparc ss20.  I think there was a memcpy fix for the initrd 
failures.  Anyway, if there is still a problem that requires the change, 
I'm willing to help track it down.

Bob
