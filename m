From: Jann Horn <jannh@google.com>
Date: Fri, 12 Oct 2018 17:22:46 +0000
Subject: Re: [PATCH v2 1/7] modules: Create rlimit for module space
Message-Id: <CAG48ez0XfGFAWDYa75COMPCsKqqGfBFOtcNuGD4_dubGf2YeAQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20181011233117.7883-1-rick.p.edgecombe@intel.com>
 <20181011233117.7883-2-rick.p.edgecombe@intel.com> <CAG48ez2fWg64nGxDXUQS3695KpVNrakAbarXJnYPd6xv5wOD+A@mail.gmail.com>
 <7b0714e26c7c2216721641d7df16a49687927e37.camel@intel.com>
In-Reply-To: <7b0714e26c7c2216721641d7df16a49687927e37.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: rick.p.edgecombe@intel.com
Cc: kernel list <linux-kernel@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Kees Cook <keescook@chromium.org>, jeyu@kernel.org, linux-arch <linux-arch@vger.kernel.org>, Arjan van de Ven <arjan@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, linux-mips@linux-mips.org, linux-s390 <linux-s390@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, kristen@linux.intel.com, deneen.t.dock@intel.com, Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Kernel Hardening <kernel-hardening@lists.openwall.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>, linux-arm-kernel@lists.infradead.org, "David S. Miller" <davem@davemloft.net>, Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org, sparclinux@vger.kernel.org

On Fri, Oct 12, 2018 at 7:04 PM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
> On Fri, 2018-10-12 at 02:35 +0200, Jann Horn wrote:
> > On Fri, Oct 12, 2018 at 1:40 AM Rick Edgecombe
> > <rick.p.edgecombe@intel.com> wrote:
> > > This introduces a new rlimit, RLIMIT_MODSPACE, which limits the amount of
> > > module space a user can use. The intention is to be able to limit module
> > > space
> > > allocations that may come from un-privlidged users inserting e/BPF filters.
> >
> > Note that in some configurations (iirc e.g. the default Ubuntu
> > config), normal users can use the subuid mechanism (the /etc/subuid
> > config file and the /usr/bin/newuidmap setuid helper) to gain access
> > to 65536 UIDs, which means that in such a configuration,
> > RLIMIT_MODSPACE*65537 is the actual limit for one user. (Same thing
> > applies to RLIMIT_MEMLOCK.)
> Ah, that is a problem. There is only room for about 130,000 filters on x86 with
> KASLR, so it couldn't really be set small enough.
>
> I'll have to look into what this is. Thanks for pointing it out.
>
> > Also, it is probably possible to waste a few times as much virtual
> > memory as permitted by the limit by deliberately fragmenting virtual
> > memory?
> Good point. I guess if the first point can be addressed somehow, this one could
> maybe be solved by just picking a lower limit.
>
> Any thoughts on if instead of all this there was just a system wide limit on BPF
> JIT module space usage?

That does sound more robust to me. And at least on systems that don't
compile out the BPF interpreter, everything should be more or less
fine then...

> > > There is unfortunately no cross platform place to perform this accounting
> > > during allocation in the module space, so instead two helpers are created to
> > > be
> > > inserted into the various arch’s that implement module_alloc. These
> > > helpers perform the checks and help with tracking. The intention is that
> > > they
> > > an be added to the various arch’s as easily as possible.
> >
> > nit: s/an/can/
> >
> > [...]
> > > diff --git a/kernel/module.c b/kernel/module.c
> > > index 6746c85511fe..2ef9ed95bf60 100644
> > > --- a/kernel/module.c
> > > +++ b/kernel/module.c
> > > @@ -2110,9 +2110,139 @@ static void free_module_elf(struct module *mod)
> > >  }
> > >  #endif /* CONFIG_LIVEPATCH */it
> > >
> > > +struct mod_alloc_user {
> > > +       struct rb_node node;
> > > +       unsigned long addr;
> > > +       unsigned long pages;
> > > +       kuid_t uid;
> > > +};
> > > +
> > > +static struct rb_root alloc_users = RB_ROOT;
> > > +static DEFINE_SPINLOCK(alloc_users_lock);
> >
> > Why all the rbtree stuff instead of stashing a pointer in struct
> > vmap_area, or something like that?
>
> Since the tracking was not for all vmalloc usage, the intention was to not bloat
> the structure for other usages likes stacks. I thought usually there wouldn't be
> nearly as much module space allocations as there would be kernel stacks, but I
> didn't do any actual measurements on the tradeoffs.

I imagine that one extra pointer in there - pointing to your struct
mod_alloc_user - would probably not be terrible. 8 bytes more per
kernel stack shouldn't be so bad?

> > [...]
> > > +int check_inc_mod_rlimit(unsigned long size)
> > > +{
> > > +       struct user_struct *user = get_current_user();
> > > +       unsigned long modspace_pages = rlimit(RLIMIT_MODSPACE) >>
> > > PAGE_SHIFT;
> > > +       unsigned long cur_pages = atomic_long_read(&user->module_vm);
> > > +       unsigned long new_pages = get_mod_page_cnt(size);
> > > +
> > > +       if (rlimit(RLIMIT_MODSPACE) != RLIM_INFINITY
> > > +                       && cur_pages + new_pages > modspace_pages) {
> > > +               free_uid(user);
> > > +               return 1;
> > > +       }
> > > +
> > > +       atomic_long_add(new_pages, &user->module_vm);
> > > +
> > > +       if (atomic_long_read(&user->module_vm) > modspace_pages) {
> > > +               atomic_long_sub(new_pages, &user->module_vm);
> > > +               free_uid(user);
> > > +               return 1;
> > > +       }
> > > +
> > > +       free_uid(user);
> >
> > If you drop the reference on the user_struct, an attacker with two
> > UIDs can charge module allocations to UID A, keep the associated
> > sockets alive as UID B, and then log out and back in again as UID A.
> > At that point, nobody is charged for the module space anymore. If you
> > look at the eBPF implementation, you'll see that
> > bpf_prog_charge_memlock() actually stores a refcounted pointer to the
> > user_struct.
> Ok, I'll take a look. Thanks Jann.
> > > +       return 0;
> > > +}
