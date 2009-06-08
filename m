From: Andrew Morton <akpm@linux-foundation.org>
Date: Mon, 08 Jun 2009 22:56:54 +0000
Subject: Re: [Bugme-new] [Bug 13489] New: us2e_cpufreq does not work on
Message-Id: <20090608155654.c3c86d37.akpm@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Mon, 8 Jun 2009 19:42:33 GMT
bugzilla-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id489
> 
>            Summary: us2e_cpufreq does not work on Netra t1 200
>            Product: Power Management
>            Version: 2.5
>     Kernel Version: 2.6.29
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: cpufreq
>         AssignedTo: cpufreq@vger.kernel.org
>         ReportedBy: seraph@xs4all.nl
>         Regression: No
> 
> 
> My Netra t1 AC 200 has an UltraSPARC IIe processor. However, the us2e_cpufreq
> driver does not work properly on it.
> 
> Loading the us2e_cpufreq module sometimes crashes the entire system; the
> console only spews endless binary garbage and the system is completely
> unresponsive until powercycled. (The LOM unit still works, fortunately.) This
> problem is intermittent, I can trigger it some of the time but not always.
> 
> However, even if the module does load without crashing the system, any attempt
> to change the governor from the default "performance" to "ondemand" immediately
> causes a watchdog reset:
> 
> seraphim ~ # modprobe us2e_cpufreq
> seraphim ~ # cpufreq-info 
> cpufrequtils 005: cpufreq-info (C) Dominik Brodowski 2004-2006
> Report errors and bugs to cpufreq@vger.kernel.org, please.
> analyzing CPU 0:
>   driver: UltraSPARC-IIe
>   CPUs which need to switch frequency at the same time: 0
>   hardware limits: 62.5 MHz - 500 MHz
>   available cpufreq governors: performance
>   current policy: frequency should be within 62.5 MHz and 500 MHz.
>                   The governor "performance" may decide which speed to use
>                   within this range.
>   current CPU frequency is 500 MHz (asserted by call to hardware).
> 
> seraphim ~ # cpufreq-set -g ondemand
> seraphim ~ #
> Watchdog Reset
> Externally Initiated Reset
> ok

