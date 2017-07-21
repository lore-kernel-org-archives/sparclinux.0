From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 21 Jul 2017 16:56:58 +0000
Subject: Re: [PATCH 1/3] sparc64: recognize and support sparc M8 cpu type
Message-Id: <20170721165658.GA6200@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1500536437-14589-1-git-send-email-allen.pais@oracle.com>
In-Reply-To: <1500536437-14589-1-git-send-email-allen.pais@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Jul 21, 2017 at 02:51:59PM +0530, Allen wrote:
> 
> Hi Sam,
> 
> >>+++ b/arch/sparc/kernel/head_64.S
> >>@@ -439,6 +439,9 @@ EXPORT_SYMBOL(sun4v_chip_type)
> >>  	cmp	%g2, '7'
> >>  	be,pt	%xcc, 5f
> >>  	 mov	SUN4V_CHIP_SPARC_M7, %g4
> >>+	cmp	%g2, '8'
> >>+	be,pt	%xcc, 5f
> >>+	 mov	SUN4V_CHIP_SPARC_M8, %g4
> >
> >Could we use this opportunity to create properly named
> >constants for '7', '8', 'N' etc, rather than harcoding these
> >in some assembler files.
> >(Obviously in a separate patch).
> 
> Would this work?

It is way better than the hardcoded values.
If the vales have any sort of name in the sparc specs
the values shall be prefixed with this.
Otherwise something like
CPU_ID_xxx

And maybe add an intro comment like this:
/* following CPU_ID_xxx constants are used to identify the
 * CPU type in the setup phase (see xxx.S)
*/

(As character constants, but that part is obvious).

	Sam

