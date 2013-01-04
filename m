From: Sergei Shtylyov <sshtylyov@mvista.com>
Date: Fri, 04 Jan 2013 19:44:33 +0000
Subject: Re: [PATCH 2/2] Revert "nohz: Fix idle ticks in cpu summary line of /proc/stat" (commit 7386cdbf2f57
Message-Id: <50E73EB6.9090100@mvista.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1357268337-8025-1-git-send-email-vatsa@codeaurora.org>
 <50E6C776.7060707@mvista.com> <20130104192934.GB29866@quicinc.com>
In-Reply-To: <20130104192934.GB29866@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

On 01/04/2013 10:29 PM, Srivatsa Vaddagiri wrote:

>>> With offline cpus no longer beeing seen in nohz mode (ts->idle_active=0), we
>>> don't need the check for cpu_online() introduced in commit 7386cdbf. Offline

>>    Please also specify the summary of that commit in parens (or
>> however you like).

> I had that in Subject line, but yes would be good to include in commit message
> as well. I will incorporate that change alongwith anything else required in
> next version of this patch.

   Ah, that was a revert with atypical subject -- didn't notice. Then there's no
need to specify it twice.

> - vatsa

WBR, Sergei

