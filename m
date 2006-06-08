From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Date: Thu, 08 Jun 2006 11:33:20 +0000
Subject: Re: 2.6.17-rc5 does not build for sparc
Message-Id: <44880b0026284@wp.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <4478bffd45960@wp.pl>
In-Reply-To: <4478bffd45960@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

My two cents to this discussion.

I consider both of these macros (write_can_lock and
read_can_lock) brain-damaged as they do not guarantee anything.=20
That's why I haven't copied the read_can_lock macro - it is not
used in the sparc kernel and let it be this way.

The write_can_lock is used in one place only - in ptrace.c file
when it is used to add a little efficiency into a waiting for two
spinlocks to be free. I suppose this call can be removed but I
afraid changing it. A whole idea there is simple: obtain one
lock, try to obtain another one and if it is not successful use
the write_can_lock macro to wait before repeating former steps. I
think that without this macro the waiting may become less
efficient - more trials of obtaining lock will be made. See the
code below:

repeat:
    /*
     * Nasty, nasty.
     *
     * We want to hold both the task-lock and the
     * tasklist_lock for writing at the same time.
     * But that's against the rules (tasklist_lock
     * is taken for reading by interrupts on other
     * cpu's that may have task_lock).
     */
    task_lock(task);
    local_irq_disable();
    if (!write_trylock(&tasklist_lock)) {
        local_irq_enable();
        task_unlock(task);
        do {
            cpu_relax();
        } while (!write_can_lock(&tasklist_lock));
        goto repeat;
    }

There is no need for this macro to be 100% accurate. It is enough
to be conservative as Bob Breuer suggested (it should not spin
waiting either). The other way is to remove the call to
write_can_lock from the code above.

I beg you (sparc32 maintainers) to start pushing smp patches (or
even parts of them) into the kernel tree. I have another patch
which clears sun4m_smp.c a little (replaced loops with
for_each_online_cpu, removed one unused global variable) but this
will stop Bob Breuer's patch from applying so I wait sitting on it.

I am able to boot a dual SM81 in SS20 with all the smp patches
from this list, but the kernel hangs on first module load. It is
something I will investigate.

Regards,
Krzysztof


----------------------------------------------------
Nowe serie superksi=B1=BFek o Czarodziejkach WITCH!
Poznaj =B6wiat bohaterek WITCH!=20
Will, Irma, Taranee, Cornelia i Hay-Lin zapraszaj=B1 do ksi=EAgarni.
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fwitch.html&s=
idx1


