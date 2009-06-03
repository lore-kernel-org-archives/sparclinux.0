From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 03 Jun 2009 21:42:41 +0000
Subject: Re: [Bugme-new] [Bug 13444] New: SparcServer 1000E SMP can cause
Message-Id: <20090603144241.99669d0e.akpm@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Wed, 3 Jun 2009 16:45:33 GMT
bugzilla-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id444
> 
>            Summary: SparcServer 1000E SMP can cause kernel-nullpointer
>                     with some hw configurations
>            Product: Platform Specific/Hardware
>            Version: 2.5
>     Kernel Version: 2.4.37
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: SPARC32
>         AssignedTo: zaitcev@yahoo.com
>         ReportedBy: oftedal@gmail.com
>         Regression: No
> 
> 
> Created an attachment (id!732)
>  --> (http://bugzilla.kernel.org/attachment.cgi?id!732)
> SUN4D-SMP mode patch
> 
> SparcServer 1000E/SUN4D machines will cause a kernel-nullpointer when running
> in SMP-mode with certain hw configurations.
> According to Sun documentation Slot A on the systemboards should be filled with
> cpu modules first. This will fill physical cpu-slots 0,2,4,8 with cpus first. 
> The current smp code will then fill the init_tasks-array using the physical
> cpu-mapping. 
> The scheduler on the other hand uses the logical cpu-mapping.
> So in a two cpu system with two systemboards cpu-slots 0 and 2 will be occupied
> and init_tasks-array position 0 and 2 will contain a idle_task. But the
> scheduler will access init_tasks position 0 and 1 which will cause an error.
> Any sparcserver 1000(E) system with 2 systemboards and 2 cpus, with 1 cpu per
> board will cause this error.
> 

Thanks, but handling patches via bugzilla is far from preferred.

Please send the patch via email, as a reply-to-all to this email.  The
patch should include a full description and a Signed-off-by:, as per
Documentation/SubmittingPatches.

