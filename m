From: Julian Calaby <julian.calaby@gmail.com>
Date: Tue, 07 Jun 2016 03:52:40 +0000
Subject: Re: [RFC] sparc64: Meaning of /sys/**/core_siblings on newer platforms.
Message-Id: <CAGRGNgWaw4HHAtMcb5go9rcE5CJjOkZ3M5-nZZFiRmbWwhAwMQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <029d528e-27bf-b55c-5dfb-335d202dc1ce@oracle.com>
In-Reply-To: <029d528e-27bf-b55c-5dfb-335d202dc1ce@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi All,

Resending without HTML. Thanks Gmail Android!

On Tue, Jun 7, 2016 at 1:07 PM, Julian Calaby <julian.calaby@gmail.com> wrote:
> Hi Chris,
>
> On 7 Jun 2016 12:11, "chris hyser" <chris.hyser@oracle.com> wrote:
>>
>>
>>
>> On 6/6/2016 8:14 PM, Julian Calaby wrote:
>>>
>>> Hi Chris,
>>>
>>> On Tue, Jun 7, 2016 at 8:23 AM, chris hyser <chris.hyser@oracle.com>
>>> wrote:
>>>>
>>>> Before SPARC T7, the notion of core_siblings was both those CPUs that
>>>> share
>>>> a
>>>> common highest level cache and the set of CPUs within a particular
>>>> socket
>>>> (share same package_id). This was also true on older x86 CPUs and
>>>> perhaps
>>>> most
>>>> recent though my knowledge of x86 is dated.
>>>>
>>>> The idea of same package_id is stated in Documentation/cputopology.txt
>>>> and
>>>> programs such as lscpu have relied upon this to find the number of
>>>> sockets
>>>> by
>>>> counting the number of unique core_siblings_list entries. I suspect the
>>>> reliance
>>>> on that algorithm predates the ability to read package IDs directly
>>>> which is
>>>> simpler, more straightforward and preserves the platform assigned
>>>> package ID
>>>> versus an ID that is just an incremented index based on order of
>>>> discovery.
>>>>
>>>> The idea that it needs to represent shared common highest level cache
>>>> comes
>>>> from irqbalance, an important run-time performance enhancing daemon.
>>>>
>>>> irqbalance uses the following hierarchy of locality goodness:
>>>>
>>>>          - shared common core (thread_siblings)
>>>>          - shared common cache (core_siblings)
>>>>          - shared common socket (CPUs with same physical_package_id)
>>>>          - shared common node (CPUS in same node)
>>>>
>>>> This layout perfectly describes the T7 and interestingly suggests that
>>>> there
>>>> are
>>>> one or more other architectures that have reached the point where enough
>>>> cores
>>>> can be jammed into the same package that a shared high level cache is
>>>> either
>>>> not
>>>> desirable or not worth the real estate/effort. Said differently, socket
>>>> in
>>>> the
>>>> future will likely become less synonymous with shared cache and instead
>>>> more
>>>> synonymous with node. I'm still digging to see if and what those
>>>> architectures
>>>> are.
>>>>
>>>> The issue is that on newer SPARC HW both definitions can no longer be
>>>> true
>>>> and
>>>> that choosing one versus the other will break differing sets of code.
>>>> This
>>>> can
>>>> be illustrated as a choice between an unmodified lscpu spitting out
>>>> nonsensical
>>>> answers (although it currently can do that for different unrelated
>>>> reasons)
>>>> or
>>>> an unmodified irqbalance incorrectly making cache-thrashing decisions.
>>>> The
>>>> number of important programs in each class is unknown, but either way
>>>> some
>>>> things will have to be fixed. As I believe the whole point of large
>>>> SPARC
>>>> servers is performance and the goal of the people on the SPARC mailing
>>>> list
>>>> is
>>>> to maximize SPARC linux performance, I would argue for not breaking what
>>>> I
>>>> would call the performance class of programs versus the topology
>>>> description
>>>> class.
>>>>
>>>> Rationale:
>>>>
>>>> - performance class breakage is harder to diagnose as it results in lost
>>>> performance and tracing back to root cause is incredibly difficult.
>>>> Topology
>>>> description programs on the other hand spit out easily identified
>>>> nonsense
>>>> and can be modified in a manner that is actually more straight forward
>>>> than
>>>> the current algorithm while preserving architecturally neutral
>>>> functional
>>>> correctness (i.e. not hacks/workarounds)
>>>>
>>>> Attached is a working sparc64 patch for redefinition in favor of "shared
>>>> highest level cache" (not intended in its current form for actual
>>>> upstream
>>>> submission but to clarify the proposal and allow actual testing). I'm
>>>> seeking
>>>> feedback on how to proceed here to prevent wasted effort fixing the
>>>> wrong
>>>> set
>>>> of user land programs and related in-progress patches for SPARC sysfs.
>>>>
>>>> Example results of patch:
>>>>
>>>> Before:
>>>>          [root@ca-sparc30 topology]# cat core_siblings_list
>>>>          32-63,128-223
>>>>
>>>> After:
>>>>          [root@ca-sparc30 topology]# cat core_siblings_list
>>>>          32-63
>>>>
>>>> diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
>>>> index 1122886..e1b3893 100644
>>>> --- a/arch/sparc/kernel/mdesc.c
>>>> +++ b/arch/sparc/kernel/mdesc.c
>>>>   @@ -597,20 +598,21 @@ static void fill_in_one_cache(cpuinfo_sparc *c,
>>>> struct mdesc_handle *hp, u64 mp)
>>>>                 c->ecache_line_size = *line_size;
>>>>                 break;
>>>>   +     case 3:
>>>
>>>
>>> Is your patch mangled?
>>
>>
>> Apparently. I had to do this is in a weird way. I tried to be extra
>> careful. Let me try again. Apologies.
>
> You should be using git-send-email unless there's something weird about your
> email setup.
>
> There's documentation on how to set up most common email clients in the
> Documentation directory of the kernel tree.
>
> Thanks,
>
> Julian Calaby



-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
