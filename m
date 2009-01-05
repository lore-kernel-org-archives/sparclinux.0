From: Steven Rostedt <rostedt@goodmis.org>
Date: Mon, 05 Jan 2009 19:46:19 +0000
Subject: Re: [PATCH] sparc: make proces_ver_nack a bit more readable
Message-Id: <alpine.DEB.1.10.0901051443100.27085@gandalf.stny.rr.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20090105181922.GA25622@uranus.ravnborg.org> <alpine.DEB.1.10.0901051428370.27085@gandalf.stny.rr.com> <alpine.DEB.1.10.0901051437490.27085@gandalf.stny.rr.com>
In-Reply-To: <alpine.DEB.1.10.0901051437490.27085@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <srostedt@redhat.com>, Ingo Molnar <mingo@elte.hu>, "David S. Miller" <davem@davemloft.net>, sparclinux <sparclinux@vger.kernel.org>


On Mon, 5 Jan 2009, Steven Rostedt wrote:

> 
> Impact: clean up
> 
> The code in process_ver_nack is a little obfuscated. This change
> makes it a bit more readable by humans. It removes the complex
> if statement and replaces it with a cleaner flow of control.

Note, I do not have a sparc compiler at my disposal, so I was not
able to compile (or boot) test this change.

Here's the original code:

static int process_ver_nack(struct ldc_channel *lp, struct ldc_version 
*vp)
{
        struct ldc_version *vap;

        if ((vp->major = 0 && vp->minor = 0) ||
            !(vap = find_by_major(vp->major))) {
                return ldc_abort(lp);
        } else {
                struct ldc_packet *p;
                unsigned long new_tail;

                p = handshake_compose_ctrl(lp, LDC_INFO, LDC_VERS,
                                           vap, sizeof(*vap),
                                           &new_tail);
                if (p)
                        return send_tx_packet(lp, p, new_tail);
                else
                        return ldc_abort(lp);
        }
}


And the new code:

static int process_ver_nack(struct ldc_channel *lp, struct ldc_version 
*vp)
{
        struct ldc_version *vap;
        struct ldc_packet *p;
        unsigned long new_tail;

        if (vp->major = 0 && vp->minor = 0)
                return ldc_abort(lp);

        vap = find_by_major(vp->major);
        if (!vap)
                return ldc_abort(lp);

        p = handshake_compose_ctrl(lp, LDC_INFO, LDC_VERS,
                                           vap, sizeof(*vap),
                                           &new_tail);
        if (!p)
                return ldc_abort(lp);

        return send_tx_packet(lp, p, new_tail);
}

This should be binary the same. But as I said, I do not have a sparc 
compiler to test.

Thanks,

-- Steve
