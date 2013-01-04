From: Srivatsa Vaddagiri <vatsa@codeaurora.org>
Date: Fri, 04 Jan 2013 19:29:34 +0000
Subject: Re: [PATCH 2/2] Revert "nohz: Fix idle ticks in cpu summary line of /proc/stat" (commit 7386cdbf2f57
Message-Id: <20130104192934.GB29866@quicinc.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1357268337-8025-1-git-send-email-vatsa@codeaurora.org>
 <50E6C776.7060707@mvista.com>
In-Reply-To: <50E6C776.7060707@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

* Sergei Shtylyov <sshtylyov@mvista.com> [2013-01-04 16:13:42]:

> >With offline cpus no longer beeing seen in nohz mode (ts->idle_active=0), we
> >don't need the check for cpu_online() introduced in commit 7386cdbf. Offline
> 
>    Please also specify the summary of that commit in parens (or
> however you like).

I had that in Subject line, but yes would be good to include in commit message
as well. I will incorporate that change alongwith anything else required in
next version of this patch.

- vatsa
