From: "Julian Calaby" <julian.calaby@gmail.com>
Date: Sat, 03 Jan 2009 03:59:15 +0000
Subject: Re: sparc - next unification bits?
Message-Id: <646765f40901021959jd666f10t16c233a7d5dbcf4@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20081227211236.GA16704@uranus.ravnborg.org>
In-Reply-To: <20081227211236.GA16704@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Jan 3, 2009 at 13:22, David Miller <davem@davemloft.net> wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Sat, 27 Dec 2008 22:12:36 +0100
>
>> So far I done some random unification where it was simple
>> and I could do so more or less in a mechanical fashion.
>>
>> But I'm running out of the easy tasks.
>>
>> Are there any places/files where you would like to see
>> some additional effort being made - but yet simple
>> enough that I can do it?
>
> An area with a lot of potential is arch/sparc/prom, I think.
>
> The trick is to decide upon a backend interface for the
> actual calls into the firmware.
>
> Sparc32 calls into the firmware by ->foo() method calls,
> and the base of the structure with the function pointers
> is given to the kernel at boot time.
>
> Sparc64 on the other hand calls into the firmware by
> invoking a single function address, again given to the
> kernel in a register at boot time, but the method to
> invoke is indicated by a string and the args are pushed
> on the stack (and the args are obtained from stack slots).
>
> Perhaps if a suitable abstraction for this stuff is
> designed, this difference in calling conventions could be
> handled which would make most of the arch/sparc/prom/
> code generic.
>
> For example we could have some prom_invoke() thing that
> would take the method name string as one of it's args,
> but that would be totally ignored by 32-bit sparc's
> implementation of this interface.  Likewise, there would
> be a method name arg, which in turn would be not used
> by 64-bit sparc.
>
> Something like that.  Just throwing out some ideas.

Adding my 2 cents:

After having a look at the code involved - particularly the
implementation of functions in arch/sparc{,64}/prom/tree.c - it seems
that the prom_*() functions are superficially identical between
sparc32 and sparc64 and the __prom_*() functions are completely
different. This gives me a bit more of an insight as to how these two
architectures are different and how the interfaces work.

As such, it may be beneficial to standardize around an interface
similar to sparc32's - i.e. a structure with ->foo() calls - and make
an implementation of this that uses sparc64's single function pointer.

I've attached a small patch that shows what I'm thinking of - however,
as my C's a little rusty, it's utterly inane and won't compile in any
sensible manner - given, of course, that Gmail hasn't mangled it.

Of course, a real implementation would split all the sparc{32,64}ness
out into separate files, leaving a nice set of pristine prom/*.c files
that reference this structure, but that isn't something you can knock
up in your lunch break.

diff --git a/arch/sparc/prom/tree.c b/arch/sparc/prom/tree.c
index f228fe0..59f8761 100644
--- a/arch/sparc/prom/tree.c
+++ b/arch/sparc/prom/tree.c
@@ -20,9 +20,23 @@ extern void restore_current(void);

 static char promlib_buf[128];

-/* Internal version of prom_getchild that does not alter return values. */
-int __prom_getchild(int node)
-{
+struct prom_ops {
+       int *get_child(int node);
+}
+
+#ifdef SPARC64
+
+int get_child_s64(int node) {
+       return p1275_cmd ("child", P1275_INOUT(1, 1), node);
+}
+
+struct prom_ops *prom_ops = {
+       .get_child = get_child_s64;
+}
+
+#else
+
+int get_child_s32(int node) {
        unsigned long flags;
        int cnode;

@@ -34,6 +48,12 @@ int __prom_getchild(int node)
        return cnode;
 }

+struct prom_ops *prom_ops = {
+       .get_child = get_child_s32;
+}
+
+#endif
+
 /* Return the child of node 'node' or zero if no this node has no
  * direct descendent.
  */
@@ -44,8 +64,8 @@ int prom_getchild(int node)
        if (node = -1)
                return 0;

-       cnode = __prom_getchild(node);
+       cnode = prom_ops->get_child(node);
        if (cnode = 0 || cnode = -1)
                return 0;

        return cnode;

-- 

Julian Calaby

Email: julian.calaby@gmail.com
