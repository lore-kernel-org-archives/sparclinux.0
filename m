From: Jurij Smakov <jurij@wooyd.org>
Date: Sat, 14 May 2005 17:43:45 +0000
Subject: Re: sparc32 2.6 work
Message-Id: <Pine.LNX.4.61.0505141313550.9740@bobcat>
List-Id: <sparclinux.vger.kernel.org>
References: <4285EE7A.7090200@bellsouth.net>
In-Reply-To: <4285EE7A.7090200@bellsouth.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Heitzso,

On Sat, 14 May 2005, Heitzso wrote:

> (if there's a specific email list I should focus on please let me know,
> or a particular individual/mentor I can work through on this to avoid
> having simple/trivial emails hassle a list .... thanks)

Please address all the user-level questions to the support channels of the 
distribution of your choice.

> I've offered to try and help with the sparc32 port of 2.6 and
> am wondering where I should start.  Seems like it makes sense
> to get UP solid before jumping into the world of SMP, but it
> may be my above problems are not really problems, or have simple
> solutions.

Well, UP in Debian is pretty solid on sparc32. I happen to own one of the 
machines with Hypersparc CPU and UP 2.6.x and Debian's pre-built kernels 
are stable enough to build other packages and kernels on it. The only 
sparc32 patch we are applying against 2.6.11 is the following:

--- kernel-source-2.6.11-2.6.11-orig//arch/sparc/mm/srmmu.c	2005-03-02 08:38:10.000000000 +0100
+++ kernel-source-2.6.11-2.6.11/arch/sparc/mm/srmmu.c	2005-03-05 10:39:38.677679448 +0100
@@ -1464,7 +1464,6 @@
  static void __init init_hypersparc(void)
  {
          srmmu_name = "ROSS HyperSparc";
-	srmmu_modtype = HyperSparc;

          init_vac_layout();

Without it the kernel fails to mount initrd on boot due to unknown reason. 
This change was discovered after numerous experiments :-). The only other 
quirk I know (which can be related) is that Debian's 2.6.8 netboot images 
do not boot Hypersparc machines (others seem to be fine), again due to the 
trouble with initrd.

> If someone could do a little hand holding and/or point out a
> small area of code for me to jump into I'll be glad to try to
> help fix the code.  But I need that mentoring because the above
> problems, much less SMP, seem to be all over the map ...

debian-sparc mailing list has been fairly active recently. I am sure 
people there would be glad to help you with your issues (given that you 
will be willing to <subliminal message>use Debian</subliminal message>, of 
course).

>
> Thanks,
> Heitzso

Best regards,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC
