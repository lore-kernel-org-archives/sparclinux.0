From: Chen Gang <gang.chen@asianux.com>
Date: Thu, 15 Nov 2012 03:22:39 +0000
Subject: [Suggestion] arch/sparc: memory overflow by using strcpy in function ldom_set_var
Message-Id: <50A45FFF.60600@asianux.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello Sam, David


in arch/sparc/kernel/ds.c: ldom_set_var function

  according to line 781, the dest memory len is less than 512.
  and the src memory len can be more than 512.
  line 793 strcpy cause issue.


the proof flow is below (total 7 Steps)


--------------------------------------------------------------------------
Step 1:

arch/sparc/include/uapi/asm/openpromio.h:19:

#define	OPROMMAXPARAM	4096		/* Maximum size of oprom_array. */


--------------------------------------------------------------------------
Step 2:

drivers/sbus/char/openprom.c: getstrings

  use OPROMMAXPARAM as memory limitition
  the bufsize is less than 4096, but can be more than 512

103 static int getstrings(struct openpromio __user *info, struct openpromio **opp_p)
104 {
105         int n, bufsize;
106         char c;
107 
108         if (!info || !opp_p)
109                 return -EFAULT;
110 
111         if (!(*opp_p = kzalloc(sizeof(int) + OPROMMAXPARAM + 1, GFP_KERNEL)))
112                 return -ENOMEM;
113 
114         (*opp_p)->oprom_size = 0;
115 
116         n = bufsize = 0;
117         while ((n < 2) && (bufsize < OPROMMAXPARAM)) {
118                 if (get_user(c, &info->oprom_array[bufsize])) {
119                         kfree(*opp_p);
120                         return -EFAULT;
121                 }
122                 if (c = '\0')
123                         n++;
124                 (*opp_p)->oprom_array[bufsize++] = c;
125         }
126         if (!n) {
127                 kfree(*opp_p);
128                 return -EINVAL;
129         }
130         return bufsize;
131 }


--------------------------------------------------------------------------
Step 3:

drivers/sbus/char/openprom.c: openprom_sunos_ioctl:

if (cmd = OPROMSETOPT)
  it will call getstrings to get parameters (at line 312)
  bufsize is less than 4096, but can be more than 512
  and then call opromsetopt at line 334

301 static long openprom_sunos_ioctl(struct file * file,
302                                  unsigned int cmd, unsigned long arg,
303                                  struct device_node *dp)
304 {
305         DATA *data = file->private_data;
306         struct openpromio *opp = NULL;
307         int bufsize, error = 0;
308         static int cnt;
309         void __user *argp = (void __user *)arg;
310 
311         if (cmd = OPROMSETOPT)
312                 bufsize = getstrings(argp, &opp);
313         else
314                 bufsize = copyin(argp, &opp);
315 
316         if (bufsize < 0)
317                 return bufsize;
318 
319         mutex_lock(&openprom_mutex);
320 
321         switch (cmd) {
322         case OPROMGETOPT:
323         case OPROMGETPROP:
324                 error = opromgetprop(argp, dp, opp, bufsize);
325                 break;
326 
327         case OPROMNXTOPT:
328         case OPROMNXTPROP:
329                 error = opromnxtprop(argp, dp, opp, bufsize);
330                 break;
331 
332         case OPROMSETOPT:
333         case OPROMSETOPT2:
334                 error = opromsetopt(dp, opp, bufsize);
335                 break;
336 
337         case OPROMNEXT:
338         case OPROMCHILD:
339         case OPROMSETCUR:
340                 error = opromnext(argp, cmd, dp, opp, bufsize, data);
341                 break;
342 
343         case OPROMPCI2NODE:
344                 error = oprompci2node(argp, dp, opp, bufsize, data);
345                 break;
346 
347         case OPROMPATH2NODE:
348                 error = oprompath2node(argp, dp, opp, bufsize, data);
349                 break;
350 
351         case OPROMGETBOOTARGS:
352                 error = opromgetbootargs(argp, opp, bufsize);
353                 break;
354 
355         case OPROMU2P:
356         case OPROMGETCONS:
357         case OPROMGETFBNAME:
358                 if (cnt++ < 10)
359                         printk(KERN_INFO "openprom_sunos_ioctl: unimplemented ioctl\n");
360                 error = -EINVAL;
361                 break;
362         default:
363                 if (cnt++ < 10)
364                         printk(KERN_INFO "openprom_sunos_ioctl: cmd 0x%X, arg 0x%lX\n", cmd, arg);
365                 error = -EINVAL;
366                 break;
367         }
368 
369         kfree(opp);
370         mutex_unlock(&openprom_mutex);
371 
372         return error;
373 }


--------------------------------------------------------------------------
Step 4:

drivers/sbus/char/openprom.c: in opromsetopt:

  it devides the strings to name (op->oprom_array) and value (buf),
  the len is less than 4096, but may be more than 512

190 static int opromsetopt(struct device_node *dp, struct openpromio *op, int bufsize)
191 {
192         char *buf = op->oprom_array + strlen(op->oprom_array) + 1;
193         int len = op->oprom_array + bufsize - buf;
194 
195         return of_set_property(options_node, op->oprom_array, buf, len);
196 }


--------------------------------------------------------------------------
Step 5:

arch/sparc/kernel/prom_common.c: of_set_property

  line 76 call prom_setprop,
  the val len may be larger than 512


54 int of_set_property(struct device_node *dp, const char *name, void *val, int len)
55 {
56         struct property **prevp;
57         void *new_val;
58         int err;
59 
60         new_val = kmemdup(val, len, GFP_KERNEL);
61         if (!new_val)
62                 return -ENOMEM;
63 
64         err = -ENODEV;
65 
66         mutex_lock(&of_set_property_mutex);
67         write_lock(&devtree_lock);
68         prevp = &dp->properties;
69         while (*prevp) {
70                 struct property *prop = *prevp;
71 
72                 if (!strcasecmp(prop->name, name)) {
73                         void *old_val = prop->value;
74                         int ret;
75 
76                         ret = prom_setprop(dp->phandle, name, val, len);
77 
78                         err = -EINVAL;
79                         if (ret >= 0) {
80                                 prop->value = new_val;
81                                 prop->length = len;
82 
83                                 if (OF_IS_DYNAMIC(prop))
84                                         kfree(old_val);
85 
86                                 OF_MARK_DYNAMIC(prop);
87 
88                                 err = 0;
89                         }
90                         break;
91                 }
92                 prevp = &(*prevp)->next;
93         }
94         write_unlock(&devtree_lock);
95         mutex_unlock(&of_set_property_mutex);
96 
97         /* XXX Upate procfs if necessary... */
98 
99         return err;
100 }
101 EXPORT_SYMBOL(of_set_property);



--------------------------------------------------------------------------
Step 6:

arch/sparc/prom/tree_64.c: prom_setprop

  line 339, may call ldom_set_var
  not check value len (maybe larger than 512 )

327 int
328 prom_setprop(phandle node, const char *pname, char *value, int size)
329 {
330         unsigned long args[8];
331 
332         if (size = 0)
333                 return 0;
334         if ((pname = 0) || (value = 0))
335                 return 0;
336 
337 #ifdef CONFIG_SUN_LDOMS
338         if (ldom_domaining_enabled) {
339                 ldom_set_var(pname, value);
340                 return 0;
341         }
342 #endif
343         args[0] = (unsigned long) "setprop";
344         args[1] = 4;
345         args[2] = 1;
346         args[3] = (unsigned int) node;
347         args[4] = (unsigned long) pname;
348         args[5] = (unsigned long) value;
349         args[6] = size;
350         args[7] = (unsigned long) -1;
351 
352         p1275_cmd_direct(args);
353 
354         return (int) args[7];
355 }
356 EXPORT_SYMBOL(prom_setprop);


--------------------------------------------------------------------------
Step 7:

arch/sparc/kernel/ds.c: ldom_set_var

  according to line 781, the dest memory len is less than 512.
  and the src memory len can be more than 512.
  line 793 strcpy cause issue.


745 void ldom_set_var(const char *var, const char *value)
746 {
747         struct ds_cap_state *cp;
748         struct ds_info *dp;
749         unsigned long flags;
750 
751         spin_lock_irqsave(&ds_lock, flags);
752         cp = NULL;
753         for (dp = ds_info_list; dp; dp = dp->next) {
754                 struct ds_cap_state *tmp;
755 
756                 tmp = find_cap_by_string(dp, "var-config");
757                 if (tmp && tmp->state = CAP_STATE_REGISTERED) {
758                         cp = tmp;
759                         break;
760                 }
761         }
762         if (!cp) {
763                 for (dp = ds_info_list; dp; dp = dp->next) {
764                         struct ds_cap_state *tmp;
765 
766                         tmp = find_cap_by_string(dp, "var-config-backup");
767                         if (tmp && tmp->state = CAP_STATE_REGISTERED) {
768                                 cp = tmp;
769                                 break;
770                         }
771                 }
772         }
773         spin_unlock_irqrestore(&ds_lock, flags);
774 
775         if (cp) {
776                 union {
777                         struct {
778                                 struct ds_data          data;
779                                 struct ds_var_set_msg   msg;
780                         } header;
781                         char                    all[512];
782                 } pkt;
783                 char  *base, *p;
784                 int msg_len, loops;
785 
786                 memset(&pkt, 0, sizeof(pkt));
787                 pkt.header.data.tag.type = DS_DATA;
788                 pkt.header.data.handle = cp->handle;
789                 pkt.header.msg.hdr.type = DS_VAR_SET_REQ;
790                 base = p = &pkt.header.msg.name_and_value[0];
791                 strcpy(p, var);
792                 p += strlen(var) + 1;
793                 strcpy(p, value);
794                 p += strlen(value) + 1;
795 
796                 msg_len = (sizeof(struct ds_data) +
797                            sizeof(struct ds_var_set_msg) +
798                            (p - base));
799                 msg_len = (msg_len + 3) & ~3;
800                 pkt.header.data.tag.len = msg_len - sizeof(struct ds_msg_tag);
801 




