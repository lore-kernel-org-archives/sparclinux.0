From: Steven Rostedt <rostedt@goodmis.org>
Date: Thu, 28 Dec 2017 16:39:15 +0000
Subject: Re: [PATCH v6 8/8] x86/kernel: jump_table: use relative references
Message-Id: <20171228113915.47838609@gandalf.local.home>
List-Id: <sparclinux.vger.kernel.org>
References: <20171227085033.22389-1-ard.biesheuvel@linaro.org>
 <20171227085033.22389-9-ard.biesheuvel@linaro.org>
 <20171228111926.28e82877@gandalf.local.home>
 <CAKv+Gu9Gza=RN_v_H-G7m7-qKg9B4Xf4GFvd_H-Gut-V3eabmA@mail.gmail.com>
In-Reply-To: <CAKv+Gu9Gza=RN_v_H-G7m7-qKg9B4Xf4GFvd_H-Gut-V3eabmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, 28 Dec 2017 16:26:07 +0000
Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> On 28 December 2017 at 16:19, Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Wed, 27 Dec 2017 08:50:33 +0000
> > Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >  
> >>  static inline jump_label_t jump_entry_code(const struct jump_entry *entry)
> >>  {
> >> -     return entry->code;
> >> +     return (jump_label_t)&entry->code + entry->code;  
> >
> > I'm paranoid about doing arithmetic on abstract types. What happens in
> > the future if jump_label_t becomes a pointer? You will get a different
> > result.
> >  
> 
> In general, I share your concern. In this case, however, jump_label_t
> is typedef'd three lines up and is never used anywhere else.

I would agree if this was in a .c file, but it's in a header file,
which causes me to be more paranoid.

> 
> > Could we switch these calculations to something like:
> >
> >         return (jump_label_t)((long)&entrty->code + entry->code);
> >  
> 
> jump_label_t is local to this .h file, so it can be defined as u32 or
> u64 depending on the word size. I don't mind adding the extra cast,
> but I am not sure if your paranoia is justified in this particular
> case. Perhaps we should just use 'unsigned long' throughout?

Actually, that may be better. Have the return value be jump_label_t,
but the cast be "unsigned long". That way it should always work.

static inline jump_label_t jump_entry_code(...)
{
	return (unsigned long)&entry->code + entry->code;
}


-- Steve
