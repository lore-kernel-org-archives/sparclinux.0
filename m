From: Anatoly Pugachev <matorola@gmail.com>
Date: Tue, 02 Jan 2018 13:56:29 +0000
Subject: Re: [sparc64] kernel unaligned access at TPC aa_dfa_unpack
Message-Id: <CADxRZqzXPMAjyh7_cr7nki=jG_LmT8xmjr-nfDtoheDA9ddt2A@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqwo8sL3RtEWRMcHkgkSAnWKeVibLRrtdXU2e8w2Q5KSTQ@mail.gmail.com>
	<20180101214245.GA9827@ravnborg.org>
In-Reply-To: <20180101214245.GA9827@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-security-module@vger.kernel.org

On Tue, Jan 2, 2018 at 12:42 AM, Sam Ravnborg <sam@ravnborg.org> wrote:
> Hi Anatoly.
>
> On Tue, Jan 02, 2018 at 12:11:49AM +0300, Anatoly Pugachev wrote:
>> Hello!
>>
>> Using latest git kernel (4.15.0-rc6) , getting the following messages
>> on LDOM/kernel boot:
>>
>> [    7.693653] Kernel unaligned access at TPC[7496d8] aa_dfa_unpack+0x38/0x580
>> [    7.693735] Kernel unaligned access at TPC[7496f8] aa_dfa_unpack+0x58/0x580
>> [    7.693782] Kernel unaligned access at TPC[749708] aa_dfa_unpack+0x68/0x580
>> [    7.693829] Kernel unaligned access at TPC[74973c] aa_dfa_unpack+0x9c/0x580
>> [    7.693875] Kernel unaligned access at TPC[749758] aa_dfa_unpack+0xb8/0x580
>> [    7.697135] audit: type=1400 audit(1514840016.480:2):
>> apparmor="STATUS" operation="profile_load" profile="unconfined"
>> name="/usr/sbin/tcpdump" pid=507 comm="apparmor_parser"
>>
>>
>> Can someone please look, what could cause unaligned access at this
>> aa_dfa_unpack function/structure ?
>
> A quick guess would be that you are using nulldfa.
> And this variable may not be aligned.
>
> Try to check the address of nulldfa_src.
>
> You could also try to force the compiler to align the data
> to 8 byte like this (security/apparmor/match.c):
>
> static char nulldfa_src[] = {
>         #include "nulldfa.in"
> } __aligned(8);                 <= see the added __aligned(8)
>
> This is just from a quick look at things, but please try it to
> see if this is the problematic spot.

Sam,

this doesn't work:

$ make
...
  CC      security/apparmor/match.o
In file included from ./include/linux/compiler_types.h:58:0,
                 from ./include/linux/linkage.h:5,
                 from ./include/linux/kernel.h:7,
                 from security/apparmor/match.c:16:
./include/linux/compiler-gcc.h:123:23: error: expected ‘,’ or ‘;’
before ‘__attribute__’
 #define __aligned(x)  __attribute__((aligned(x)))
                       ^
security/apparmor/match.c:30:3: note: in expansion of macro ‘__aligned’
 } __aligned(8);
   ^~~~~~~~~
scripts/Makefile.build:310: recipe for target 'security/apparmor/match.o' failed

$ git diff
diff --git a/security/apparmor/match.c b/security/apparmor/match.c
index 72c604350e80..8f42ab8fc365 100644
--- a/security/apparmor/match.c
+++ b/security/apparmor/match.c
@@ -27,7 +27,7 @@

 static char nulldfa_src[] = {
        #include "nulldfa.in"
-};
+} __aligned(8);
 struct aa_dfa *nulldfa;

 int aa_setup_dfa_engine(void)
~/linux-2.6$
