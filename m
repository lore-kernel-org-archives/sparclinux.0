From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Wed, 11 Oct 2006 12:22:37 +0000
Subject: Re: [PATCH 4/4] fix sparc32 modpost warnings
Message-Id: <20061011122237.GA3038@palantir8>
List-Id: <sparclinux.vger.kernel.org>
References: <20061010154635.GE30909@palantir8>
In-Reply-To: <20061010154635.GE30909@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Oct 10, 2006 at 02:44:48PM -0700, David Miller wrote:
> From: Martin Habets <errandir_news@mph.eclipse.co.uk>
> Date: Tue, 10 Oct 2006 16:46:35 +0100
> 
> > Fix this 2.6.19-rc1 build warnings from modpost:
> > 
> > WARNING: vmlinux - Section mismatch: reference to .init.text:sunzilog_console_setup from .data between 'sunzilog_console' (at offset 0x8394) and 'devices_subsys'
> >
> >Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>
>  ...
> > -static struct console sunzilog_console = {
> > +static struct console sunzilog_console_ops = {
> 
> I'll apply this, but why does simply changing the symbol
> name make the section conflict go away?

Ok, I'll be more verbose in future. This patch works because modpost
has a couple of patterns built-in that it ignores. I could have picked
any pattern listed below, but felt _ops was the most apropriate one
here.

From the comments for secref_whitelist():
 * Pattern 2:
 *   Many drivers utilise a *driver container with references to
 *   add, remove, probe functions etc.
 *   These functions may often be marked __init and we do not want to
 *   warn here.
 *   the pattern is identified by:
 *   tosec   = .init.text | .exit.text | .init.data
 *   fromsec = .data
 *   atsym = *driver, *_template, *_sht, *_ops, *_probe, *probe_one

More on the other patches later.

Thanks,
-- 
Martin
