From: Steven Rostedt <rostedt@goodmis.org>
Date: Thu, 17 Oct 2013 17:35:43 +0000
Subject: Re: [PATCH 5/7] jump_label: relax branch hinting restrictions
Message-Id: <20131017133543.7e4e8d45@gandalf.local.home>
List-Id: <sparclinux.vger.kernel.org>
References: <1382004631-25895-1-git-send-email-rkrcmar@redhat.com>
 <1382004631-25895-6-git-send-email-rkrcmar@redhat.com>
In-Reply-To: <1382004631-25895-6-git-send-email-rkrcmar@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

On Thu, 17 Oct 2013 12:10:28 +0200
Radim Krčmář <rkrcmar@redhat.com> wrote:

> We implemented the optimized branch selection in higher levels of api.
> That made static_keys very unintuitive, so this patch introduces another
> element to jump_table, carrying one bit that tells the underlying code
> which branch to optimize.
> 
> It is now possible to select optimized branch for every jump_entry.
> 
> Current side effect is 1/3 increase increase in space, we could:
> * use bitmasks and selectors on 2+ aligned code/struct.
>   - aligning jump target is easy, but because it is not done by default
>     and few bytes in .text are much worse that few kilos in .data,
>     I chose not to
>   - data is probably aligned by default on all current architectures,
>     but programmer can force misalignment of static_key
> * optimize each architecture independently
>   - I can't test everything and this patch shouldn't break anything, so
>     others can contribute in the future
> * choose something worse, like packing or splitting
> * ignore
> 
> proof: example & x86_64 disassembly: (F = ffffffff)
> 
>   struct static_key flexible_feature;
>   noinline void jump_label_experiment(void) {
>   	if ( static_key_false(&flexible_feature))
>   	     asm ("push 0xa1");
>   	else asm ("push 0xa0");
>   	if (!static_key_false(&flexible_feature))
>   	     asm ("push 0xb0");
>   	else asm ("push 0xb1");
>   	if ( static_key_true(&flexible_feature))
>   	     asm ("push 0xc1");
>   	else asm ("push 0xc0");
>   	if (!static_key_true(&flexible_feature))
>   	     asm ("push 0xd0");
>   	else asm ("push 0xd1");
>   }
> 
>   Disassembly of section .text: (push marked by "->")
> 
>   F81002000 <jump_label_experiment>:
>   F81002000:       e8 7b 29 75 00          callq  F81754980 <__fentry__>
>   F81002005:       55                      push   %rbp
>   F81002006:       48 89 e5                mov    %rsp,%rbp
>   F81002009:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
>   F8100200e: ->    ff 34 25 a0 00 00 00    pushq  0xa0
>   F81002015:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
>   F8100201a: ->    ff 34 25 b0 00 00 00    pushq  0xb0
>   F81002021:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
>   F81002026: ->    ff 34 25 c1 00 00 00    pushq  0xc1
>   F8100202d:       0f 1f 00                nopl   (%rax)
>   F81002030:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
>   F81002035: ->    ff 34 25 d1 00 00 00    pushq  0xd1
>   F8100203c:       5d                      pop    %rbp
>   F8100203d:       0f 1f 00                nopl   (%rax)
>   F81002040:       c3                      retq

This looks exactly like what we want. I take it this is with your
patch. What was the result before the patch?

-- Steve

>   F81002041:       0f 1f 80 00 00 00 00    nopl   0x0(%rax)
>   F81002048: ->    ff 34 25 d0 00 00 00    pushq  0xd0
>   F8100204f:       5d                      pop    %rbp
>   F81002050:       c3                      retq
>   F81002051:       0f 1f 80 00 00 00 00    nopl   0x0(%rax)
>   F81002058: ->    ff 34 25 c0 00 00 00    pushq  0xc0
>   F8100205f:       90                      nop
>   F81002060:       eb cb                   jmp    F8100202d <[...]+0x2d>
>   F81002062:       66 0f 1f 44 00 00       nopw   0x0(%rax,%rax,1)
>   F81002068: ->    ff 34 25 b1 00 00 00    pushq  0xb1
>   F8100206f:       90                      nop
>   F81002070:       eb af                   jmp    F81002021 <[...]+0x21>
>   F81002072:       66 0f 1f 44 00 00       nopw   0x0(%rax,%rax,1)
>   F81002078: ->    ff 34 25 a1 00 00 00    pushq  0xa1
>   F8100207f:       90                      nop
>   F81002080:       eb 93                   jmp    F81002015 <[...]+0x15>
>   F81002082:       66 66 66 66 66 2e 0f    [...]
>   F81002089:       1f 84 00 00 00 00 00
> 
>   Contents of section .data: (relevant part of embedded __jump_table)
