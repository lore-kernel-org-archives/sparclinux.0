From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Thu, 05 Feb 2009 22:08:06 +0000
Subject: Re: hang on panic, can not return to OBP
Message-Id: <Pine.LNX.4.61.0902052140110.23072@mtfhpc.demon.co.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="1750305931-1220873959-1233871686=:23072"
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0902051204550.17957@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0902051204550.17957@math.ut.ee>
To: sparclinux@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1750305931-1220873959-1233871686=:23072
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

Hi Meelis,

On sun4c, the only solution I ever managed to get close to working was a 
prom-based polling loop of the keyboard at the end of panic(). This only 
works when the processor is still running.

'soft lockups' (normally caused by recursion issues when I have 
encountered them) always ended in power-up reset because they stopped the 
processor. I ended up changing the soft lockup code to do a panic before 
things got too out of hand (ie always panic). This reduced the number of 
times I had to power cycle my aging hardware.

It was still an issue for me last time I did any kernel testing (2.6.23 
over a year ago) and if you are having the same issues I had (sparc 
processor hardware lockup) a power up reset each time, untill you can find 
and prevent the recursion issue, is the only option.

Please find attached my sun4c Panic handling patch. A bit old but may 
still be usefull (Not in text as my email client makes a mess of in text 
patches).

Regards
 	Mark

On Thu, 5 Feb 2009, Meelis Roos wrote:

> Hello,
>
> I started to debug my latest problem with Quad HME. First there is a
> OF mapping problem, then on quad also a IRQ problem, these I did not
> touch. Then came prontk recursion problem that caused panic, this I did
> not touch yet. The panic told I cpuld return to PROM with Stop-A but I
> couldn't, and this was the problem I tried to solve.
>
> First, why tell the user to press Stop-A or break at all? Is it because
> we can extract information from Break-T, Break-P etc? Otherwise the
> panic code could drop to prom itself?
>
> I tried the following patch and that did not work - probably because of
> the same reason that Break did not work (interrupts off?). Seems the
> local_irq_enable() is not enough - but what could help here? Is
> prom_halt() the right thing? ... Kad a look of waht Stop-A does, tried
> also the second patch... but if it would have worked, Stop-A wouldb
> prpbaly also have.
>
> This patch is of course not even close to merging, it's just a hack to
> try it out.
>
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 2a2ff36..ffe6f2a 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -22,6 +22,9 @@
> #include <linux/random.h>
> #include <linux/kallsyms.h>
> #include <linux/dmi.h>
> +#ifdef __sparc__
> +#include <asm/oplib.h>
> +#endif
>
> int panic_on_oops;
> static unsigned long tainted_mask;
> @@ -120,13 +123,16 @@ NORET_TYPE void panic(const char * fmt, ...)
> 		extern int stop_a_enabled;
> 		/* Make sure the user can actually press Stop-A (L1-A) */
> 		stop_a_enabled = 1;
> -		printk(KERN_EMERG "Press Stop-A (L1-A) to return to the boot prom\n");
> +		printk(KERN_EMERG "Returning to the boot prom\n");
> 	}
> #endif
> #if defined(CONFIG_S390)
> 	disabled_wait(caller);
> #endif
> 	local_irq_enable();
> +#ifdef __sparc__
> +	prom_halt();
> +#endif
> 	for (i = 0;;) {
> 		touch_softlockup_watchdog();
> 		i += panic_blink(i);
>
>
> And the other one:
>
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 2a2ff36..df46a5c 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -22,6 +22,9 @@
> #include <linux/random.h>
> #include <linux/kallsyms.h>
> #include <linux/dmi.h>
> +#ifdef __sparc__
> +#include <asm/oplib.h>
> +#endif
>
> int panic_on_oops;
> static unsigned long tainted_mask;
> @@ -120,13 +123,19 @@ NORET_TYPE void panic(const char * fmt, ...)
> 		extern int stop_a_enabled;
> 		/* Make sure the user can actually press Stop-A (L1-A) */
> 		stop_a_enabled = 1;
> -		printk(KERN_EMERG "Press Stop-A (L1-A) to return to the boot prom\n");
> +		printk(KERN_EMERG "Returning to the boot prom\n");
> 	}
> #endif
> #if defined(CONFIG_S390)
> 	disabled_wait(caller);
> #endif
> 	local_irq_enable();
> +#ifdef __sparc__
> +	prom_printf("\n");
> +	flush_user_windows();
> +
> +	prom_cmdline();
> +#endif
> 	for (i = 0;;) {
> 		touch_softlockup_watchdog();
> 		i += panic_blink(i);
>
> -- 
> Meelis Roos (mroos@linux.ee)
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--1750305931-1220873959-1233871686=:23072
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="Panic.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.61.0902052208030.23072@mtfhpc.demon.co.uk>
Content-Description: 
Content-Disposition: attachment; filename="Panic.patch"

ZGlmZiAtcnVOcGQgbGludXgtMi42LjIwLjkva2VybmVsL3BhbmljLmMgbGlu
dXgtdGVzdC9rZXJuZWwvcGFuaWMuYw0KLS0tIGxpbnV4LTIuNi4yMC45L2tl
cm5lbC9wYW5pYy5jCTIwMDctMDQtMjggMTU6MDI6MjEuMDAwMDAwMDAwICsw
MTAwDQorKysgbGludXgtdGVzdC9rZXJuZWwvcGFuaWMuYwkyMDA3LTA0LTI4
IDA0OjA5OjI4LjAwMDAwMDAwMCArMDEwMA0KQEAgLTEwNiw2ICsxMDYsNyBA
QCBOT1JFVF9UWVBFIHZvaWQgcGFuaWMoY29uc3QgY2hhciAqIGZtdCwgDQog
CSAJICogRGVsYXkgdGltZW91dCBzZWNvbmRzIGJlZm9yZSByZWJvb3Rpbmcg
dGhlIG1hY2hpbmUuIA0KIAkJICogV2UgY2FuJ3QgdXNlIHRoZSAibm9ybWFs
IiB0aW1lcnMgc2luY2Ugd2UganVzdCBwYW5pY2tlZC4uDQogCSAJICovDQor
CSAgICAgICAgcHJpbnRrKCJcbiIpOw0KIAkJcHJpbnRrKEtFUk5fRU1FUkcg
IlJlYm9vdGluZyBpbiAlZCBzZWNvbmRzLi4iLHBhbmljX3RpbWVvdXQpOw0K
IAkJZm9yIChpID0gMDsgaSA8IHBhbmljX3RpbWVvdXQqMTAwMDsgKSB7DQog
CQkJdG91Y2hfbm1pX3dhdGNoZG9nKCk7DQpAQCAtMTI0LDYgKzEyNSw3IEBA
IE5PUkVUX1RZUEUgdm9pZCBwYW5pYyhjb25zdCBjaGFyICogZm10LCANCiAJ
CWV4dGVybiBpbnQgc3RvcF9hX2VuYWJsZWQ7DQogCQkvKiBNYWtlIHN1cmUg
dGhlIHVzZXIgY2FuIGFjdHVhbGx5IHByZXNzIFN0b3AtQSAoTDEtQSkgKi8N
CiAJCXN0b3BfYV9lbmFibGVkID0gMTsNCisJCXByaW50ayAoIlxuIik7DQog
CQlwcmludGsoS0VSTl9FTUVSRyAiUHJlc3MgU3RvcC1BIChMMS1BKSB0byBy
ZXR1cm4gdG8gdGhlIGJvb3QgcHJvbVxuIik7DQogCX0NCiAjZW5kaWYNCkBA
IC0xMzYsNiArMTM4LDMzIEBAIE5PUkVUX1RZUEUgdm9pZCBwYW5pYyhjb25z
dCBjaGFyICogZm10LCANCiAJCWkgKz0gcGFuaWNfYmxpbmsoaSk7DQogCQlt
ZGVsYXkoMSk7DQogCQlpKys7DQorI2lmZGVmIF9fc3BhcmNfXw0KKwkJew0K
KwkJCS8qDQorCQkJICogTDEtQSBwcm9jZXNzaW5nIG9ubHkgd29ya3MgaWYg
S0JEIHN0dWZmIE9LLg0KKwkJCSAqIFNvIHRvIGRlYnVnIGJlZm9yZSBLQkQg
dXAgeW91IHJlcXVpcmUgdGhpcy4NCisJCQkgKiBNYXliZSBtYWtlIHRoaXMg
cGFydCBvZiB0aGUgZWFybHkgY29uc29sZSBzdHVmLg0KKwkJCSAqLw0KKwkJ
CXN0YXRpYyBpbnQgc3RvcF9sMTsNCisJCQlpbnQgICAgICAgIGNoOw0KKwkJ
CWV4dGVybiBpbnQgcHJvbV9uYmdldGNoYXIodm9pZCk7DQorDQorCQkJaWYg
KChjaCA9IHByb21fbmJnZXRjaGFyKCkpICE9IC0xKQ0KKwkJCXsNCisJCQkJ
aWYgKChjaCA9PSAweDdGKSB8fA0KKwkJCQkgICAgKGNoID09IDB4RkUpIHx8
IChjaCA9PSAweEZGKSkNCisJCQkJCXN0b3BfbDEgPSAwOw0KKwkJCQlpZiAo
KGNoICYgMHg3RikgPT0gMHgwMSkNCisJCQkJCXN0b3BfbDEgPSAxOw0KKwkJ
CQlpZiAoc3RvcF9sMSAmJiAoKGNoICYgMHg3RikgPT0gNzcpKQ0KKwkJCQl7
DQorCQkJCQlleHRlcm4gdm9pZCBzdW5fZG9fYnJlYWsodm9pZCk7DQorDQor
CQkJCQlzdW5fZG9fYnJlYWsoKTsNCisJCQkJfQ0KKwkJCX0NCisJCX0NCisj
ZW5kaWYgLyogX19zcGFyY19fICovDQogCX0NCiB9DQogDQpkaWZmIC1ydSAt
eCAnLmdpdConIC14IC5tYWlsbWFwIGxpbnV4LTIuNi9kcml2ZXJzL3Nlcmlh
bC9zdW56aWxvZy5jIGxpbnV4LXRlc3QvZHJpdmVycy9zZXJpYWwvc3Vuemls
b2cuYw0KLS0tIGxpbnV4LTIuNi9kcml2ZXJzL3NlcmlhbC9zdW56aWxvZy5j
CTIwMDctMDYtMTUgMjI6MDg6NDUuMDAwMDAwMDAwICswMTAwDQorKysgbGlu
dXgtdGVzdC9kcml2ZXJzL3NlcmlhbC9zdW56aWxvZy5jCTIwMDctMDYtMDMg
MDA6MzU6MDMuMDAwMDAwMDAwICswMTAwDQpAQCAtNDI5LDYgKzQyOSw3IEBA
DQogCQkJLyogV2FpdCBmb3IgQlJFQUsgdG8gZGVhc3NlcnQgdG8gYXZvaWQg
cG90ZW50aWFsbHkNCiAJCQkgKiBjb25mdXNpbmcgdGhlIFBST00uDQogCQkJ
ICovDQorCQkJc3VuX2RvX2JyZWFrKCk7IC8qIE9uIFN1bjRjLCB0aGUgd2hp
bGUgbG9vcCBoYW5ncyAqLw0KIAkJCXdoaWxlICgxKSB7DQogCQkJCXN0YXR1
cyA9IHJlYWRiKCZjaGFubmVsLT5jb250cm9sKTsNCiAJCQkJWlNERUxBWSgp
Ow0KZGlmZiAtcnUgLXggJy5naXQqJyAteCAubWFpbG1hcCBsaW51eC0yLjYv
a2VybmVsL3NvZnRsb2NrdXAuYyBsaW51eC10ZXN0L2tlcm5lbC9zb2Z0bG9j
a3VwLmMNCi0tLSBsaW51eC0yLjYva2VybmVsL3NvZnRsb2NrdXAuYwkyMDA3
LTA2LTE1IDIyOjA4OjQ2LjAwMDAwMDAwMCArMDEwMA0KKysrIGxpbnV4LXRl
c3Qva2VybmVsL3NvZnRsb2NrdXAuYwkyMDA3LTA2LTAzIDAwOjMxOjAwLjAw
MDAwMDAwMCArMDEwMA0KQEAgLTEwNSw2ICsxMDUsNyBAQA0KIAkJCXRoaXNf
Y3B1KTsNCiAJCWR1bXBfc3RhY2soKTsNCiAJCXNwaW5fdW5sb2NrKCZwcmlu
dF9sb2NrKTsNCisJCXBhbmljICgiU3VuNGMgY2FuJ3QgY29wZSB3aXRoIHNv
ZnQgbG9ja3Vwc1xuIik7DQogCX0NCiB9DQogDQo=

--1750305931-1220873959-1233871686=:23072--
