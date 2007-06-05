From: Dmitry Mishin <dim@openvz.org>
Date: Tue, 05 Jun 2007 13:50:02 +0000
Subject: Re: iptables throws unknown error - suspecting 32/64 compat issue
Message-Id: <200706051750.03185.dim@openvz.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0705100812440.32349@yvahk01.tjqt.qr>
	<4665542F.9020607@trash.net> <466565F6.7070902@trash.net>
In-Reply-To: <466565F6.7070902@trash.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netfilter-devel@lists.netfilter.org
Cc: sparclinux@vger.kernel.org, Patrick McHardy <kaber@trash.net>, Jan Engelhardt <jengelh@linux01.gwdg.de>

On Tuesday 05 June 2007 17:32, Patrick McHardy wrote:
> Patrick McHardy wrote:
> > Dmitry Mishin wrote:
> >>It's better, but I see the issue with iterate with compat_check_entry()
> >> calls. If it fails, some of target/matches' check_* functions are
> >> called, some not. Please, review my version of this patch.
> >
> > You're right again, thanks. Patch applied.
>
> With one minor change:
No probs, thanks Patrick, for your work!

-- 
Thanks,
Dmitry.
