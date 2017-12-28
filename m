From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 28 Dec 2017 23:24:37 +0000
Subject: Re: [PATCH v6 5/8] kernel: tracepoints: add support for relative references
Message-Id: <CAKv+Gu-R6yf8C=ZgO8G5vmR+MZtFTijRg6+tH+qscT4ycy1PrQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20171227085033.22389-1-ard.biesheuvel@linaro.org>
 <20171227085033.22389-6-ard.biesheuvel@linaro.org>
 <20171228104207.117ee0ff@gandalf.local.home>
In-Reply-To: <20171228104207.117ee0ff@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 28 December 2017 at 15:42, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 27 Dec 2017 08:50:30 +0000
> Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
>> To avoid the need for relocating absolute references to tracepoint
>> structures at boot time when running relocatable kernels (which may
>> take a disproportionate amount of space), add the option to emit
>> these tables as relative references instead.
>>
>
> I gave this patch a quick skim over. It appears to not modify anything
> when CONFIG_HAVE_PREL32_RELOCATIONS is not defined. I haven't
> thoroughly reviewed it or tested it. But if it doesn't break anything,
> I'm fine giving you an ack.
>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>

Thank you Steven.

I should mention though (as you don't appear to recall) that an
earlier version of this patch triggered an issue for you

https://marc.info/?l=linux-arch&m0584374820168&w=2

but I have never managed to reproduce it, neither at the time nor
currently with this v6.


ard@bezzzef:~/linux-2.6$ sudo tools/testing/selftests/ftrace/ftracetest
== Ftrace unit tests =[1] Basic trace file check [PASS]
[2] Basic test for tracers [PASS]
[3] Basic trace clock test [PASS]
[4] Basic event tracing check [PASS]
[5] event tracing - enable/disable with event level files [PASS]
[6] event tracing - restricts events based on pid [PASS]
[7] event tracing - enable/disable with subsystem level files [PASS]
[8] event tracing - enable/disable with top level files [PASS]
[9] ftrace - function graph filters with stack tracer [PASS]
[10] ftrace - function graph filters [PASS]
[11] ftrace - test for function event triggers [PASS]
[12] ftrace - function glob filters [PASS]
[13] ftrace - function pid filters [PASS]
[14] ftrace - function profiler with function tracing [PASS]
[15] ftrace - test reading of set_ftrace_filter [PASS]
[16] ftrace - test for function traceon/off triggers [PASS]
[17] Test creation and deletion of trace instances while setting an event [PASS]
[18] Test creation and deletion of trace instances [PASS]
[19] Kprobe dynamic event - adding and removing [PASS]
[20] Kprobe dynamic event - busy event check [PASS]
[21] Kprobe dynamic event with arguments [PASS]
[22] Kprobes event arguments with types [PASS]
[23] Kprobe event auto/manual naming [PASS]
[24] Kprobe dynamic event with function tracer [PASS]
[25] Kprobe dynamic event - probing module [PASS]
[26] Kretprobe dynamic event with arguments [PASS]
[27] Kretprobe dynamic event with maxactive [PASS]
[28] Register/unregister many kprobe events [PASS]
[29] event trigger - test event enable/disable trigger [PASS]
[30] event trigger - test trigger filter [PASS]
[31] event trigger - test histogram modifiers [PASS]
[32] event trigger - test histogram trigger [PASS]
[33] event trigger - test multiple histogram triggers [PASS]
[34] event trigger - test snapshot-trigger [PASS]
[35] event trigger - test stacktrace-trigger [PASS]
[36] event trigger - test traceon/off trigger [PASS]
[37] (instance)  Basic test for tracers [PASS]
[38] (instance)  Basic trace clock test [PASS]
[39] (instance)  event tracing - enable/disable with event level files [PASS]
[40] (instance)  event tracing - restricts events based on pid [PASS]
[41] (instance)  event tracing - enable/disable with subsystem level
files [PASS]
[42] (instance)  ftrace - test for function event triggers [PASS]
[43] (instance)  ftrace - test for function traceon/off triggers [PASS]
[44] (instance)  event trigger - test event enable/disable trigger [PASS]
[45] (instance)  event trigger - test trigger filter [PASS]
[46] (instance)  event trigger - test histogram modifiers [PASS]
[47] (instance)  event trigger - test histogram trigger [PASS]
[48] (instance)  event trigger - test multiple histogram triggers [PASS]

# of passed:  48
# of failed:  0
# of unresolved:  0
# of untested:  0
# of unsupported:  0
# of xfailed:  0
# of undefined(test bug):  0
