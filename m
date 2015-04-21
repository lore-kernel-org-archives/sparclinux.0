From: chris hyser <chris.hyser@oracle.com>
Date: Tue, 21 Apr 2015 18:25:40 +0000
Subject: Re: [PATCH v3] sparc64: Setup sysfs to mark LDOM sockets, cores and threads correctly
Message-Id: <55369624.5040703@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <5526cf9b.DFcVpFfcq8CBXHg7%chris.hyser@oracle.com>
In-Reply-To: <5526cf9b.DFcVpFfcq8CBXHg7%chris.hyser@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 4/16/2015 3:41 PM, David Miller wrote:
> From: David Miller <davem@davemloft.net>
> Date: Thu, 09 Apr 2015 19:06:47 -0400 (EDT)
>> How will this work on T3, T2, and T1 which all neither have the
>> "socket" mdesc nodes nor level 3 caches?
>
> I'm still waiting for you to resolve this Chris.
>
> I don't think it's much effort to make this change back down
> to using the level=2 cache if no level=3 cache is found.  Please
> implement that and resubmit.

So that does appear to work. This is not the patch. I will send that out shortly but I thought I'd give you a chance to 
provide feedback while I'm getting that ready.

Here is what I see on a T2.

before:
-----------------
tct2000-52> lscpu
Architecture:          sparc64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Big Endian
CPU(s):                32
On-line CPU(s) list:   0-31
Thread(s) per core:    4
Core(s) per socket:    1
Socket(s):             8

after:
----------------------
tct2000-52> lscpu
Architecture:          sparc64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Big Endian
CPU(s):                32
On-line CPU(s) list:   0-31
Thread(s) per core:    4
Core(s) per socket:    8
Socket(s):             1


Diff from the prior patch (I also see some cleanup here I will do):

diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
index 78beb94..75e2890 100644
--- a/arch/sparc/kernel/mdesc.c
+++ b/arch/sparc/kernel/mdesc.c
@@ -694,23 +694,26 @@ static void set_core_ids(struct mdesc_handle *hp)
         }
  }

-static void set_sock_ids_by_cache(struct mdesc_handle *hp, u64 mp)
+static int set_sock_ids_by_cache(struct mdesc_handle *hp, u64 mp, int level)
  {
         int idx = 1;
+       int fnd = 0;

         /* Identify unique sockets by looking for cpus backpointed to by
-        * level 3 caches.
+        * shared level n caches.
          */
         mdesc_for_each_node_by_name(hp, mp, "cache") {
-               const u64 *level;
+               const u64 *cur_lvl;

-               level = mdesc_get_property(hp, mp, "level", NULL);
-               if (*level != 3)
+               cur_lvl = mdesc_get_property(hp, mp, "level", NULL);
+               if (*cur_lvl != level)
                         continue;

                 mark_sock_ids(hp, mp, idx);
                 idx++;
+               fnd = 1;
         }
+       return fnd;
  }

  static void set_sock_ids_by_socket(struct mdesc_handle *hp, u64 mp)
@@ -742,11 +745,12 @@ static void set_sock_ids(struct mdesc_handle *hp)
         u64 mp;

         /* If machine description exposes sockets data use it.
-        * Otherwise fallback to use L3 cache
+        * Otherwise fallback to use shared L3 or L2 caches
          */
         mp = mdesc_node_by_name(hp, MDESC_NODE_NULL, "sockets");
         if (mp = MDESC_NODE_NULL)
-               return set_sock_ids_by_cache(hp, mp);
+               if (!set_sock_ids_by_cache(hp, mp, 3))
+                       set_sock_ids_by_cache(hp, mp, 2);

         return set_sock_ids_by_socket(hp, mp);
  }

