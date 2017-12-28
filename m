From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 28 Dec 2017 16:26:07 +0000
Subject: Re: [PATCH v6 8/8] x86/kernel: jump_table: use relative references
Message-Id: <CAKv+Gu9Gza=RN_v_H-G7m7-qKg9B4Xf4GFvd_H-Gut-V3eabmA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20171227085033.22389-1-ard.biesheuvel@linaro.org>
 <20171227085033.22389-9-ard.biesheuvel@linaro.org>
 <20171228111926.28e82877@gandalf.local.home>
In-Reply-To: <20171228111926.28e82877@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 28 December 2017 at 16:19, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 27 Dec 2017 08:50:33 +0000
> Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
>>  static inline jump_label_t jump_entry_code(const struct jump_entry *entry)
>>  {
>> -     return entry->code;
>> +     return (jump_label_t)&entry->code + entry->code;
>
> I'm paranoid about doing arithmetic on abstract types. What happens in
> the future if jump_label_t becomes a pointer? You will get a different
> result.
>

In general, I share your concern. In this case, however, jump_label_t
is typedef'd three lines up and is never used anywhere else.

> Could we switch these calculations to something like:
>
>         return (jump_label_t)((long)&entrty->code + entry->code);
>

jump_label_t is local to this .h file, so it can be defined as u32 or
u64 depending on the word size. I don't mind adding the extra cast,
but I am not sure if your paranoia is justified in this particular
case. Perhaps we should just use 'unsigned long' throughout?

>> +}
>> +
>> +static inline jump_label_t jump_entry_target(const struct jump_entry *entry)
>> +{
>> +     return (jump_label_t)&entry->target + entry->target;
>>  }
>>
>>  static inline struct static_key *jump_entry_key(const struct jump_entry *entry)
>>  {
>> -     return (struct static_key *)((unsigned long)entry->key & ~1UL);
>> +     unsigned long key = (unsigned long)&entry->key + entry->key;
>> +
>> +     return (struct static_key *)(key & ~1UL);
>>  }
>>
>>  static inline bool jump_entry_is_branch(const struct jump_entry *entry)
>> @@ -99,7 +106,7 @@ static inline void jump_entry_set_module_init(struct jump_entry *entry)
>>       entry->code = 0;
>>  }
>>
>> -#define jump_label_swap              NULL
>> +void jump_label_swap(void *a, void *b, int size);
>>
>>  #else        /* __ASSEMBLY__ */
>>
>> @@ -114,8 +121,8 @@ static inline void jump_entry_set_module_init(struct jump_entry *entry)
>>       .byte           STATIC_KEY_INIT_NOP
>>       .endif
>>       .pushsection __jump_table, "aw"
>> -     _ASM_ALIGN
>> -     _ASM_PTR        .Lstatic_jump_\@, \target, \key
>> +     .balign         4
>> +     .long           .Lstatic_jump_\@ - ., \target - ., \key - .
>>       .popsection
>>  .endm
>>
>> @@ -130,8 +137,8 @@ static inline void jump_entry_set_module_init(struct jump_entry *entry)
>>  .Lstatic_jump_after_\@:
>>       .endif
>>       .pushsection __jump_table, "aw"
>> -     _ASM_ALIGN
>> -     _ASM_PTR        .Lstatic_jump_\@, \target, \key + 1
>> +     .balign         4
>> +     .long           .Lstatic_jump_\@ - ., \target - ., \key - . + 1
>>       .popsection
>>  .endm
>>
>> diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
>> index e56c95be2808..cc5034b42335 100644
>> --- a/arch/x86/kernel/jump_label.c
>> +++ b/arch/x86/kernel/jump_label.c
>> @@ -52,22 +52,24 @@ static void __jump_label_transform(struct jump_entry *entry,
>>                        * Jump label is enabled for the first time.
>>                        * So we expect a default_nop...
>>                        */
>> -                     if (unlikely(memcmp((void *)entry->code, default_nop, 5)
>> -                                  != 0))
>> -                             bug_at((void *)entry->code, __LINE__);
>> +                     if (unlikely(memcmp((void *)jump_entry_code(entry),
>> +                                         default_nop, 5) != 0))
>> +                             bug_at((void *)jump_entry_code(entry),
>
> You have the functions already made before this patch. Perhaps we
> should have a separate patch to use them (here and elsewhere) before
> you make the conversion to using relative references. It will help out
> in debugging and bisects. To know if the use of functions is an issue,
> or the conversion of relative references is an issue.
>
> I suggest splitting this into two patches.
>

Fair enough.


>> +                                    __LINE__);
>>               } else {
>>                       /*
>>                        * ...otherwise expect an ideal_nop. Otherwise
>>                        * something went horribly wrong.
>>                        */
>> -                     if (unlikely(memcmp((void *)entry->code, ideal_nop, 5)
>> -                                  != 0))
>> -                             bug_at((void *)entry->code, __LINE__);
>> +                     if (unlikely(memcmp((void *)jump_entry_code(entry),
>> +                                         ideal_nop, 5) != 0))
>> +                             bug_at((void *)jump_entry_code(entry),
>> +                                    __LINE__);
>>               }
>>
>>               code.jump = 0xe9;
>> -             code.offset = entry->target -
>> -                             (entry->code + JUMP_LABEL_NOP_SIZE);
>> +             code.offset = jump_entry_target(entry) -
>> +                           (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
>>       } else {
>>               /*
>>                * We are disabling this jump label. If it is not what
>> @@ -76,14 +78,18 @@ static void __jump_label_transform(struct jump_entry *entry,
>>                * are converting the default nop to the ideal nop.
>>                */
>>               if (init) {
>> -                     if (unlikely(memcmp((void *)entry->code, default_nop, 5) != 0))
>> -                             bug_at((void *)entry->code, __LINE__);
>> +                     if (unlikely(memcmp((void *)jump_entry_code(entry),
>> +                                         default_nop, 5) != 0))
>> +                             bug_at((void *)jump_entry_code(entry),
>> +                                    __LINE__);
>>               } else {
>>                       code.jump = 0xe9;
>> -                     code.offset = entry->target -
>> -                             (entry->code + JUMP_LABEL_NOP_SIZE);
>> -                     if (unlikely(memcmp((void *)entry->code, &code, 5) != 0))
>> -                             bug_at((void *)entry->code, __LINE__);
>> +                     code.offset = jump_entry_target(entry) -
>> +                             (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
>> +                     if (unlikely(memcmp((void *)jump_entry_code(entry),
>> +                                  &code, 5) != 0))
>> +                             bug_at((void *)jump_entry_code(entry),
>> +                                    __LINE__);
>>               }
>>               memcpy(&code, ideal_nops[NOP_ATOMIC5], JUMP_LABEL_NOP_SIZE);
>>       }
>> @@ -97,10 +103,13 @@ static void __jump_label_transform(struct jump_entry *entry,
>>        *
>>        */
>>       if (poker)
>> -             (*poker)((void *)entry->code, &code, JUMP_LABEL_NOP_SIZE);
>> +             (*poker)((void *)jump_entry_code(entry), &code,
>> +                      JUMP_LABEL_NOP_SIZE);
>>       else
>> -             text_poke_bp((void *)entry->code, &code, JUMP_LABEL_NOP_SIZE,
>> -                          (void *)entry->code + JUMP_LABEL_NOP_SIZE);
>> +             text_poke_bp((void *)jump_entry_code(entry), &code,
>> +                          JUMP_LABEL_NOP_SIZE,
>> +                          (void *)jump_entry_code(entry) +
>> +                          JUMP_LABEL_NOP_SIZE);
>>  }
>>
>>  void arch_jump_label_transform(struct jump_entry *entry,
>> @@ -140,4 +149,20 @@ __init_or_module void arch_jump_label_transform_static(struct jump_entry *entry,
>>               __jump_label_transform(entry, type, text_poke_early, 1);
>>  }
>>
>> +void jump_label_swap(void *a, void *b, int size)
>> +{
>> +     long delta = (unsigned long)a - (unsigned long)b;
>> +     struct jump_entry *jea = a;
>> +     struct jump_entry *jeb = b;
>> +     struct jump_entry tmp = *jea;
>> +
>> +     jea->code       = jeb->code - delta;
>> +     jea->target     = jeb->target - delta;
>> +     jea->key        = jeb->key - delta;
>> +
>> +     jeb->code       = tmp.code + delta;
>> +     jeb->target     = tmp.target + delta;
>> +     jeb->key        = tmp.key + delta;
>> +}
>> +
>>  #endif
>> diff --git a/tools/objtool/special.c b/tools/objtool/special.c
>> index 84f001d52322..98ae55b39037 100644
>> --- a/tools/objtool/special.c
>> +++ b/tools/objtool/special.c
>> @@ -30,9 +30,9 @@
>>  #define EX_ORIG_OFFSET               0
>>  #define EX_NEW_OFFSET                4
>>
>> -#define JUMP_ENTRY_SIZE              24
>> +#define JUMP_ENTRY_SIZE              12
>>  #define JUMP_ORIG_OFFSET     0
>> -#define JUMP_NEW_OFFSET              8
>> +#define JUMP_NEW_OFFSET              4
>>
>>  #define ALT_ENTRY_SIZE               13
>>  #define ALT_ORIG_OFFSET              0
>
