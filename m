From: Bob Picco <bpicco@meloft.net>
Date: Wed, 10 Sep 2014 14:32:53 +0000
Subject: Re: [PATCH] sparc64: T5 PMU
Message-Id: <20140910143253.GF17331@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <1410104989-22564-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1410104989-22564-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:	[Tue Sep 09 2014, 06:13:48PM EDT]
> From: Bob Picco <bpicco@meloft.net>
> Date: Sun,  7 Sep 2014 11:49:49 -0400
> 
> > From: bob picco <bpicco@meloft.net>
> > 
> > The T5 (niagara5) has different PCR related HV fast trap values and a new
> > HV API Group. This patch utilizes these and shares when possible with niagara4.
> > 
> > We use the same sparc_pmu niagara4_pmu. Should there be new effort to
> > obtain the MCU perf statistics then this would have to be changed.
> > 
> > Cc: sparclinux@vger.kernel.org
> > Signed-off-by: Bob Picco <bob.picco@oracle.com>
> 
> This patch looks fine but needs some minor coding style fixups.
Okay.
> > +unsigned long sun4v_t5_get_perfreg(unsigned long reg_num,
> > +				   unsigned long *reg_val);
> 
> Arguments on the second and subsequent line of a function declaration
> or call need to start exactly at the first column after the openning
> parenthesis of the first line.  You must use the appropriate number
> of TAB and SPACE characters necessary to achieve this.
My Berkeley and Bell Labs style always creeps back in. Sorry.
> 
> > -		if (sun4v_hvapi_register(perf_hsvc_group,
> > +		hverror = sun4v_hvapi_register(perf_hsvc_group,
> >  					 perf_hsvc_major,
> 
> Since you are changing where the openning parenthesis of this function
> call is located, you have to reindent the following lines as needed.
Okay. I'll ask another person locally should my confusion remain :)
> 
> > +			pr_err("perfmon: Could not register hvapi(0x%lx).\n",
> > +				hverror);
> 
> Not a blocker for this patch, but we probably want an "hverr_to_string()"
> helper function so that we can print these out mnenomically.
I agree. 

thanx for the review,

bob
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
