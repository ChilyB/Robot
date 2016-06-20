
bin/main.elf:     file format elf32-littlearm


Disassembly of section .text:

08000188 <thread_ending>:
 8000188:	b672      	cpsid	i
 800018a:	4b05      	ldr	r3, [pc, #20]	; (80001a0 <thread_ending+0x18>)
 800018c:	681a      	ldr	r2, [r3, #0]
 800018e:	4b05      	ldr	r3, [pc, #20]	; (80001a4 <thread_ending+0x1c>)
 8000190:	210c      	movs	r1, #12
 8000192:	fb01 3302 	mla	r3, r1, r2, r3
 8000196:	2200      	movs	r2, #0
 8000198:	605a      	str	r2, [r3, #4]
 800019a:	b662      	cpsie	i
 800019c:	bf00      	nop
 800019e:	e7fd      	b.n	800019c <thread_ending+0x14>
 80001a0:	2000007c 	.word	0x2000007c
 80001a4:	20000034 	.word	0x20000034

080001a8 <null_thread>:
 80001a8:	b508      	push	{r3, lr}
 80001aa:	f002 f93d 	bl	8002428 <sleep>
 80001ae:	e7fc      	b.n	80001aa <null_thread+0x2>

080001b0 <scheduler>:
 80001b0:	b570      	push	{r4, r5, r6, lr}
 80001b2:	2200      	movs	r2, #0
 80001b4:	4611      	mov	r1, r2
 80001b6:	4b15      	ldr	r3, [pc, #84]	; (800020c <scheduler+0x5c>)
 80001b8:	200c      	movs	r0, #12
 80001ba:	fb00 f401 	mul.w	r4, r0, r1
 80001be:	191e      	adds	r6, r3, r4
 80001c0:	6875      	ldr	r5, [r6, #4]
 80001c2:	f015 0f02 	tst.w	r5, #2
 80001c6:	461d      	mov	r5, r3
 80001c8:	d10a      	bne.n	80001e0 <scheduler+0x30>
 80001ca:	6876      	ldr	r6, [r6, #4]
 80001cc:	07f6      	lsls	r6, r6, #31
 80001ce:	d507      	bpl.n	80001e0 <scheduler+0x30>
 80001d0:	4350      	muls	r0, r2
 80001d2:	5b1c      	ldrh	r4, [r3, r4]
 80001d4:	5a18      	ldrh	r0, [r3, r0]
 80001d6:	b2a4      	uxth	r4, r4
 80001d8:	b280      	uxth	r0, r0
 80001da:	4284      	cmp	r4, r0
 80001dc:	bf38      	it	cc
 80001de:	460a      	movcc	r2, r1
 80001e0:	200c      	movs	r0, #12
 80001e2:	4348      	muls	r0, r1
 80001e4:	5a1c      	ldrh	r4, [r3, r0]
 80001e6:	b2a4      	uxth	r4, r4
 80001e8:	b11c      	cbz	r4, 80001f2 <scheduler+0x42>
 80001ea:	5a1c      	ldrh	r4, [r3, r0]
 80001ec:	3c01      	subs	r4, #1
 80001ee:	b2a4      	uxth	r4, r4
 80001f0:	521c      	strh	r4, [r3, r0]
 80001f2:	3101      	adds	r1, #1
 80001f4:	2906      	cmp	r1, #6
 80001f6:	d1de      	bne.n	80001b6 <scheduler+0x6>
 80001f8:	230c      	movs	r3, #12
 80001fa:	4353      	muls	r3, r2
 80001fc:	18e9      	adds	r1, r5, r3
 80001fe:	8849      	ldrh	r1, [r1, #2]
 8000200:	b289      	uxth	r1, r1
 8000202:	52e9      	strh	r1, [r5, r3]
 8000204:	4b02      	ldr	r3, [pc, #8]	; (8000210 <scheduler+0x60>)
 8000206:	601a      	str	r2, [r3, #0]
 8000208:	bd70      	pop	{r4, r5, r6, pc}
 800020a:	bf00      	nop
 800020c:	20000034 	.word	0x20000034
 8000210:	2000007c 	.word	0x2000007c

08000214 <SysTick_Handler>:
 8000214:	e92d 0ff0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, fp}
 8000218:	f3ef 8308 	mrs	r3, MSP
 800021c:	4c0d      	ldr	r4, [pc, #52]	; (8000254 <SysTick_Handler+0x40>)
 800021e:	4d0e      	ldr	r5, [pc, #56]	; (8000258 <SysTick_Handler+0x44>)
 8000220:	6822      	ldr	r2, [r4, #0]
 8000222:	3201      	adds	r2, #1
 8000224:	bf1d      	ittte	ne
 8000226:	6822      	ldrne	r2, [r4, #0]
 8000228:	210c      	movne	r1, #12
 800022a:	fb01 5202 	mlane	r2, r1, r2, r5
 800022e:	2300      	moveq	r3, #0
 8000230:	bf14      	ite	ne
 8000232:	6093      	strne	r3, [r2, #8]
 8000234:	6023      	streq	r3, [r4, #0]
 8000236:	f7ff ffbb 	bl	80001b0 <scheduler>
 800023a:	6822      	ldr	r2, [r4, #0]
 800023c:	230c      	movs	r3, #12
 800023e:	fb03 5302 	mla	r3, r3, r2, r5
 8000242:	689a      	ldr	r2, [r3, #8]
 8000244:	f06f 0306 	mvn.w	r3, #6
 8000248:	469e      	mov	lr, r3
 800024a:	f382 8808 	msr	MSP, r2
 800024e:	e8bd 0ff0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, fp}
 8000252:	4770      	bx	lr
 8000254:	2000007c 	.word	0x2000007c
 8000258:	20000034 	.word	0x20000034

0800025c <sched_off>:
 800025c:	b672      	cpsid	i
 800025e:	4770      	bx	lr

08000260 <sched_on>:
 8000260:	b662      	cpsie	i
 8000262:	4770      	bx	lr

08000264 <yield>:
 8000264:	bf00      	nop
 8000266:	4770      	bx	lr

08000268 <get_thread_id>:
 8000268:	b082      	sub	sp, #8
 800026a:	b672      	cpsid	i
 800026c:	4b03      	ldr	r3, [pc, #12]	; (800027c <get_thread_id+0x14>)
 800026e:	681b      	ldr	r3, [r3, #0]
 8000270:	9301      	str	r3, [sp, #4]
 8000272:	b662      	cpsie	i
 8000274:	9801      	ldr	r0, [sp, #4]
 8000276:	b002      	add	sp, #8
 8000278:	4770      	bx	lr
 800027a:	bf00      	nop
 800027c:	2000007c 	.word	0x2000007c

08000280 <kernel_start>:
 8000280:	b508      	push	{r3, lr}
 8000282:	f002 f8bf 	bl	8002404 <sys_tick_init>
 8000286:	bf00      	nop
 8000288:	e7fd      	b.n	8000286 <kernel_start+0x6>
	...

0800028c <create_thread>:
 800028c:	f022 0203 	bic.w	r2, r2, #3
 8000290:	3a40      	subs	r2, #64	; 0x40
 8000292:	e92d 41f0 	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
 8000296:	eb01 0e02 	add.w	lr, r1, r2
 800029a:	f102 0634 	add.w	r6, r2, #52	; 0x34
 800029e:	f102 0738 	add.w	r7, r2, #56	; 0x38
 80002a2:	323c      	adds	r2, #60	; 0x3c
 80002a4:	440e      	add	r6, r1
 80002a6:	440f      	add	r7, r1
 80002a8:	4411      	add	r1, r2
 80002aa:	2200      	movs	r2, #0
 80002ac:	b672      	cpsid	i
 80002ae:	f8df c054 	ldr.w	ip, [pc, #84]	; 8000304 <create_thread+0x78>
 80002b2:	250c      	movs	r5, #12
 80002b4:	4355      	muls	r5, r2
 80002b6:	eb0c 0405 	add.w	r4, ip, r5
 80002ba:	f8d4 8004 	ldr.w	r8, [r4, #4]
 80002be:	f018 0f01 	tst.w	r8, #1
 80002c2:	d114      	bne.n	80002ee <create_thread+0x62>
 80002c4:	f8df 8040 	ldr.w	r8, [pc, #64]	; 8000308 <create_thread+0x7c>
 80002c8:	f8c4 e008 	str.w	lr, [r4, #8]
 80002cc:	2b05      	cmp	r3, #5
 80002ce:	f8c6 8000 	str.w	r8, [r6]
 80002d2:	bf98      	it	ls
 80002d4:	2306      	movls	r3, #6
 80002d6:	f04f 5804 	mov.w	r8, #553648128	; 0x21000000
 80002da:	6038      	str	r0, [r7, #0]
 80002dc:	f8c1 8000 	str.w	r8, [r1]
 80002e0:	8063      	strh	r3, [r4, #2]
 80002e2:	f82c 3005 	strh.w	r3, [ip, r5]
 80002e6:	2501      	movs	r5, #1
 80002e8:	6065      	str	r5, [r4, #4]
 80002ea:	4614      	mov	r4, r2
 80002ec:	e000      	b.n	80002f0 <create_thread+0x64>
 80002ee:	2406      	movs	r4, #6
 80002f0:	b662      	cpsie	i
 80002f2:	3201      	adds	r2, #1
 80002f4:	2a06      	cmp	r2, #6
 80002f6:	d001      	beq.n	80002fc <create_thread+0x70>
 80002f8:	2c06      	cmp	r4, #6
 80002fa:	d0d7      	beq.n	80002ac <create_thread+0x20>
 80002fc:	4620      	mov	r0, r4
 80002fe:	e8bd 81f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, pc}
 8000302:	bf00      	nop
 8000304:	20000034 	.word	0x20000034
 8000308:	08000189 	.word	0x08000189

0800030c <kernel_init>:
 800030c:	b510      	push	{r4, lr}
 800030e:	2300      	movs	r3, #0
 8000310:	490b      	ldr	r1, [pc, #44]	; (8000340 <kernel_init+0x34>)
 8000312:	220c      	movs	r2, #12
 8000314:	435a      	muls	r2, r3
 8000316:	188c      	adds	r4, r1, r2
 8000318:	2000      	movs	r0, #0
 800031a:	6060      	str	r0, [r4, #4]
 800031c:	3301      	adds	r3, #1
 800031e:	2006      	movs	r0, #6
 8000320:	4283      	cmp	r3, r0
 8000322:	8060      	strh	r0, [r4, #2]
 8000324:	5288      	strh	r0, [r1, r2]
 8000326:	d1f3      	bne.n	8000310 <kernel_init+0x4>
 8000328:	4b06      	ldr	r3, [pc, #24]	; (8000344 <kernel_init+0x38>)
 800032a:	4807      	ldr	r0, [pc, #28]	; (8000348 <kernel_init+0x3c>)
 800032c:	4907      	ldr	r1, [pc, #28]	; (800034c <kernel_init+0x40>)
 800032e:	f04f 32ff 	mov.w	r2, #4294967295	; 0xffffffff
 8000332:	601a      	str	r2, [r3, #0]
 8000334:	e8bd 4010 	ldmia.w	sp!, {r4, lr}
 8000338:	2280      	movs	r2, #128	; 0x80
 800033a:	23ff      	movs	r3, #255	; 0xff
 800033c:	f7ff bfa6 	b.w	800028c <create_thread>
 8000340:	20000034 	.word	0x20000034
 8000344:	2000007c 	.word	0x2000007c
 8000348:	080001a9 	.word	0x080001a9
 800034c:	20000080 	.word	0x20000080

08000350 <set_wait_state>:
 8000350:	b507      	push	{r0, r1, r2, lr}
 8000352:	f7ff ff89 	bl	8000268 <get_thread_id>
 8000356:	9000      	str	r0, [sp, #0]
 8000358:	b672      	cpsid	i
 800035a:	4b0d      	ldr	r3, [pc, #52]	; (8000390 <set_wait_state+0x40>)
 800035c:	9a00      	ldr	r2, [sp, #0]
 800035e:	210c      	movs	r1, #12
 8000360:	fb01 3202 	mla	r2, r1, r2, r3
 8000364:	6851      	ldr	r1, [r2, #4]
 8000366:	f041 0102 	orr.w	r1, r1, #2
 800036a:	6051      	str	r1, [r2, #4]
 800036c:	b672      	cpsid	i
 800036e:	9a00      	ldr	r2, [sp, #0]
 8000370:	210c      	movs	r1, #12
 8000372:	fb01 3202 	mla	r2, r1, r2, r3
 8000376:	6852      	ldr	r2, [r2, #4]
 8000378:	9201      	str	r2, [sp, #4]
 800037a:	b662      	cpsie	i
 800037c:	9a01      	ldr	r2, [sp, #4]
 800037e:	0791      	lsls	r1, r2, #30
 8000380:	d500      	bpl.n	8000384 <set_wait_state+0x34>
 8000382:	bf00      	nop
 8000384:	9a01      	ldr	r2, [sp, #4]
 8000386:	0792      	lsls	r2, r2, #30
 8000388:	d4f0      	bmi.n	800036c <set_wait_state+0x1c>
 800038a:	b003      	add	sp, #12
 800038c:	f85d fb04 	ldr.w	pc, [sp], #4
 8000390:	20000034 	.word	0x20000034

08000394 <wake_up_threads>:
 8000394:	2300      	movs	r3, #0
 8000396:	b672      	cpsid	i
 8000398:	4906      	ldr	r1, [pc, #24]	; (80003b4 <wake_up_threads+0x20>)
 800039a:	220c      	movs	r2, #12
 800039c:	fb02 1203 	mla	r2, r2, r3, r1
 80003a0:	6851      	ldr	r1, [r2, #4]
 80003a2:	f021 0102 	bic.w	r1, r1, #2
 80003a6:	6051      	str	r1, [r2, #4]
 80003a8:	b662      	cpsie	i
 80003aa:	3301      	adds	r3, #1
 80003ac:	2b06      	cmp	r3, #6
 80003ae:	d1f2      	bne.n	8000396 <wake_up_threads+0x2>
 80003b0:	4770      	bx	lr
 80003b2:	bf00      	nop
 80003b4:	20000034 	.word	0x20000034

080003b8 <messages_init>:
 80003b8:	4a0a      	ldr	r2, [pc, #40]	; (80003e4 <messages_init+0x2c>)
 80003ba:	2300      	movs	r3, #0
 80003bc:	b510      	push	{r4, lr}
 80003be:	6013      	str	r3, [r2, #0]
 80003c0:	6053      	str	r3, [r2, #4]
 80003c2:	6093      	str	r3, [r2, #8]
 80003c4:	60d3      	str	r3, [r2, #12]
 80003c6:	6113      	str	r3, [r2, #16]
 80003c8:	6153      	str	r3, [r2, #20]
 80003ca:	4c07      	ldr	r4, [pc, #28]	; (80003e8 <messages_init+0x30>)
 80003cc:	0118      	lsls	r0, r3, #4
 80003ce:	1821      	adds	r1, r4, r0
 80003d0:	3301      	adds	r3, #1
 80003d2:	2200      	movs	r2, #0
 80003d4:	2b04      	cmp	r3, #4
 80003d6:	604a      	str	r2, [r1, #4]
 80003d8:	5022      	str	r2, [r4, r0]
 80003da:	60ca      	str	r2, [r1, #12]
 80003dc:	608a      	str	r2, [r1, #8]
 80003de:	d1f4      	bne.n	80003ca <messages_init+0x12>
 80003e0:	bd10      	pop	{r4, pc}
 80003e2:	bf00      	nop
 80003e4:	20000100 	.word	0x20000100
 80003e8:	20000118 	.word	0x20000118

080003ec <strlen_>:
 80003ec:	4602      	mov	r2, r0
 80003ee:	4603      	mov	r3, r0
 80003f0:	1a98      	subs	r0, r3, r2
 80003f2:	f813 1b01 	ldrb.w	r1, [r3], #1
 80003f6:	2900      	cmp	r1, #0
 80003f8:	d1fa      	bne.n	80003f0 <strlen_+0x4>
 80003fa:	4770      	bx	lr

080003fc <putc_>:
 80003fc:	b538      	push	{r3, r4, r5, lr}
 80003fe:	4c06      	ldr	r4, [pc, #24]	; (8000418 <putc_+0x1c>)
 8000400:	4605      	mov	r5, r0
 8000402:	4620      	mov	r0, r4
 8000404:	f000 f901 	bl	800060a <mutex_lock>
 8000408:	4628      	mov	r0, r5
 800040a:	f001 fda1 	bl	8001f50 <uart_write>
 800040e:	4620      	mov	r0, r4
 8000410:	e8bd 4038 	ldmia.w	sp!, {r3, r4, r5, lr}
 8000414:	f000 b915 	b.w	8000642 <mutex_unlock>
 8000418:	20000158 	.word	0x20000158

0800041c <puts_>:
 800041c:	b510      	push	{r4, lr}
 800041e:	4604      	mov	r4, r0
 8000420:	4807      	ldr	r0, [pc, #28]	; (8000440 <puts_+0x24>)
 8000422:	f000 f8f2 	bl	800060a <mutex_lock>
 8000426:	3c01      	subs	r4, #1
 8000428:	f814 0f01 	ldrb.w	r0, [r4, #1]!
 800042c:	b110      	cbz	r0, 8000434 <puts_+0x18>
 800042e:	f7ff ffe5 	bl	80003fc <putc_>
 8000432:	e7f9      	b.n	8000428 <puts_+0xc>
 8000434:	4802      	ldr	r0, [pc, #8]	; (8000440 <puts_+0x24>)
 8000436:	e8bd 4010 	ldmia.w	sp!, {r4, lr}
 800043a:	f000 b902 	b.w	8000642 <mutex_unlock>
 800043e:	bf00      	nop
 8000440:	20000164 	.word	0x20000164

08000444 <puti_>:
 8000444:	b530      	push	{r4, r5, lr}
 8000446:	b085      	sub	sp, #20
 8000448:	1e03      	subs	r3, r0, #0
 800044a:	f04f 0200 	mov.w	r2, #0
 800044e:	bfba      	itte	lt
 8000450:	425b      	neglt	r3, r3
 8000452:	2401      	movlt	r4, #1
 8000454:	4614      	movge	r4, r2
 8000456:	f88d 200f 	strb.w	r2, [sp, #15]
 800045a:	210a      	movs	r1, #10
 800045c:	220a      	movs	r2, #10
 800045e:	a801      	add	r0, sp, #4
 8000460:	fb93 f5f2 	sdiv	r5, r3, r2
 8000464:	fb02 3315 	mls	r3, r2, r5, r3
 8000468:	3330      	adds	r3, #48	; 0x30
 800046a:	540b      	strb	r3, [r1, r0]
 800046c:	1e4a      	subs	r2, r1, #1
 800046e:	462b      	mov	r3, r5
 8000470:	b10d      	cbz	r5, 8000476 <puti_+0x32>
 8000472:	4611      	mov	r1, r2
 8000474:	e7f2      	b.n	800045c <puti_+0x18>
 8000476:	b12c      	cbz	r4, 8000484 <puti_+0x40>
 8000478:	ab04      	add	r3, sp, #16
 800047a:	4413      	add	r3, r2
 800047c:	212d      	movs	r1, #45	; 0x2d
 800047e:	f803 1c0c 	strb.w	r1, [r3, #-12]
 8000482:	4611      	mov	r1, r2
 8000484:	4408      	add	r0, r1
 8000486:	f7ff ffc9 	bl	800041c <puts_>
 800048a:	b005      	add	sp, #20
 800048c:	bd30      	pop	{r4, r5, pc}

0800048e <putui_>:
 800048e:	b51f      	push	{r0, r1, r2, r3, r4, lr}
 8000490:	2300      	movs	r3, #0
 8000492:	f88d 300f 	strb.w	r3, [sp, #15]
 8000496:	220a      	movs	r2, #10
 8000498:	230a      	movs	r3, #10
 800049a:	a901      	add	r1, sp, #4
 800049c:	fbb0 f4f3 	udiv	r4, r0, r3
 80004a0:	fb03 0314 	mls	r3, r3, r4, r0
 80004a4:	3330      	adds	r3, #48	; 0x30
 80004a6:	5453      	strb	r3, [r2, r1]
 80004a8:	4620      	mov	r0, r4
 80004aa:	1e53      	subs	r3, r2, #1
 80004ac:	b10c      	cbz	r4, 80004b2 <putui_+0x24>
 80004ae:	461a      	mov	r2, r3
 80004b0:	e7f2      	b.n	8000498 <putui_+0xa>
 80004b2:	1888      	adds	r0, r1, r2
 80004b4:	f7ff ffb2 	bl	800041c <puts_>
 80004b8:	b004      	add	sp, #16
 80004ba:	bd10      	pop	{r4, pc}

080004bc <putx_>:
 80004bc:	b51f      	push	{r0, r1, r2, r3, r4, lr}
 80004be:	2300      	movs	r3, #0
 80004c0:	f88d 300f 	strb.w	r3, [sp, #15]
 80004c4:	220a      	movs	r2, #10
 80004c6:	f000 030f 	and.w	r3, r0, #15
 80004ca:	2b09      	cmp	r3, #9
 80004cc:	a901      	add	r1, sp, #4
 80004ce:	bf94      	ite	ls
 80004d0:	3330      	addls	r3, #48	; 0x30
 80004d2:	3357      	addhi	r3, #87	; 0x57
 80004d4:	0900      	lsrs	r0, r0, #4
 80004d6:	548b      	strb	r3, [r1, r2]
 80004d8:	f102 33ff 	add.w	r3, r2, #4294967295	; 0xffffffff
 80004dc:	d001      	beq.n	80004e2 <putx_+0x26>
 80004de:	461a      	mov	r2, r3
 80004e0:	e7f1      	b.n	80004c6 <putx_+0xa>
 80004e2:	1888      	adds	r0, r1, r2
 80004e4:	f7ff ff9a 	bl	800041c <puts_>
 80004e8:	b005      	add	sp, #20
 80004ea:	f85d fb04 	ldr.w	pc, [sp], #4
	...

080004f0 <printf_>:
 80004f0:	b40f      	push	{r0, r1, r2, r3}
 80004f2:	b537      	push	{r0, r1, r2, r4, r5, lr}
 80004f4:	ac06      	add	r4, sp, #24
 80004f6:	4826      	ldr	r0, [pc, #152]	; (8000590 <printf_+0xa0>)
 80004f8:	f854 5b04 	ldr.w	r5, [r4], #4
 80004fc:	f000 f885 	bl	800060a <mutex_lock>
 8000500:	9401      	str	r4, [sp, #4]
 8000502:	2400      	movs	r4, #0
 8000504:	5d28      	ldrb	r0, [r5, r4]
 8000506:	2800      	cmp	r0, #0
 8000508:	d039      	beq.n	800057e <printf_+0x8e>
 800050a:	2825      	cmp	r0, #37	; 0x25
 800050c:	d003      	beq.n	8000516 <printf_+0x26>
 800050e:	f7ff ff75 	bl	80003fc <putc_>
 8000512:	3401      	adds	r4, #1
 8000514:	e7f6      	b.n	8000504 <printf_+0x14>
 8000516:	192b      	adds	r3, r5, r4
 8000518:	7858      	ldrb	r0, [r3, #1]
 800051a:	2869      	cmp	r0, #105	; 0x69
 800051c:	d016      	beq.n	800054c <printf_+0x5c>
 800051e:	d808      	bhi.n	8000532 <printf_+0x42>
 8000520:	2825      	cmp	r0, #37	; 0x25
 8000522:	d028      	beq.n	8000576 <printf_+0x86>
 8000524:	2863      	cmp	r0, #99	; 0x63
 8000526:	d128      	bne.n	800057a <printf_+0x8a>
 8000528:	9b01      	ldr	r3, [sp, #4]
 800052a:	1d1a      	adds	r2, r3, #4
 800052c:	9201      	str	r2, [sp, #4]
 800052e:	7818      	ldrb	r0, [r3, #0]
 8000530:	e021      	b.n	8000576 <printf_+0x86>
 8000532:	2875      	cmp	r0, #117	; 0x75
 8000534:	d011      	beq.n	800055a <printf_+0x6a>
 8000536:	2878      	cmp	r0, #120	; 0x78
 8000538:	d016      	beq.n	8000568 <printf_+0x78>
 800053a:	2873      	cmp	r0, #115	; 0x73
 800053c:	d11d      	bne.n	800057a <printf_+0x8a>
 800053e:	9b01      	ldr	r3, [sp, #4]
 8000540:	1d1a      	adds	r2, r3, #4
 8000542:	6818      	ldr	r0, [r3, #0]
 8000544:	9201      	str	r2, [sp, #4]
 8000546:	f7ff ff69 	bl	800041c <puts_>
 800054a:	e016      	b.n	800057a <printf_+0x8a>
 800054c:	9b01      	ldr	r3, [sp, #4]
 800054e:	1d1a      	adds	r2, r3, #4
 8000550:	6818      	ldr	r0, [r3, #0]
 8000552:	9201      	str	r2, [sp, #4]
 8000554:	f7ff ff76 	bl	8000444 <puti_>
 8000558:	e00f      	b.n	800057a <printf_+0x8a>
 800055a:	9b01      	ldr	r3, [sp, #4]
 800055c:	1d1a      	adds	r2, r3, #4
 800055e:	6818      	ldr	r0, [r3, #0]
 8000560:	9201      	str	r2, [sp, #4]
 8000562:	f7ff ff94 	bl	800048e <putui_>
 8000566:	e008      	b.n	800057a <printf_+0x8a>
 8000568:	9b01      	ldr	r3, [sp, #4]
 800056a:	1d1a      	adds	r2, r3, #4
 800056c:	6818      	ldr	r0, [r3, #0]
 800056e:	9201      	str	r2, [sp, #4]
 8000570:	f7ff ffa4 	bl	80004bc <putx_>
 8000574:	e001      	b.n	800057a <printf_+0x8a>
 8000576:	f7ff ff41 	bl	80003fc <putc_>
 800057a:	3402      	adds	r4, #2
 800057c:	e7c2      	b.n	8000504 <printf_+0x14>
 800057e:	4804      	ldr	r0, [pc, #16]	; (8000590 <printf_+0xa0>)
 8000580:	f000 f85f 	bl	8000642 <mutex_unlock>
 8000584:	b003      	add	sp, #12
 8000586:	e8bd 4030 	ldmia.w	sp!, {r4, r5, lr}
 800058a:	b004      	add	sp, #16
 800058c:	4770      	bx	lr
 800058e:	bf00      	nop
 8000590:	20000160 	.word	0x20000160

08000594 <stdio_init>:
 8000594:	b510      	push	{r4, lr}
 8000596:	480e      	ldr	r0, [pc, #56]	; (80005d0 <stdio_init+0x3c>)
 8000598:	f000 f82d 	bl	80005f6 <mutex_init>
 800059c:	480d      	ldr	r0, [pc, #52]	; (80005d4 <stdio_init+0x40>)
 800059e:	f000 f82a 	bl	80005f6 <mutex_init>
 80005a2:	480d      	ldr	r0, [pc, #52]	; (80005d8 <stdio_init+0x44>)
 80005a4:	f000 f827 	bl	80005f6 <mutex_init>
 80005a8:	480c      	ldr	r0, [pc, #48]	; (80005dc <stdio_init+0x48>)
 80005aa:	f000 f824 	bl	80005f6 <mutex_init>
 80005ae:	2408      	movs	r4, #8
 80005b0:	2020      	movs	r0, #32
 80005b2:	f7ff ff23 	bl	80003fc <putc_>
 80005b6:	3c01      	subs	r4, #1
 80005b8:	d1fa      	bne.n	80005b0 <stdio_init+0x1c>
 80005ba:	2420      	movs	r4, #32
 80005bc:	200a      	movs	r0, #10
 80005be:	f7ff ff1d 	bl	80003fc <putc_>
 80005c2:	3c01      	subs	r4, #1
 80005c4:	d1fa      	bne.n	80005bc <stdio_init+0x28>
 80005c6:	4806      	ldr	r0, [pc, #24]	; (80005e0 <stdio_init+0x4c>)
 80005c8:	e8bd 4010 	ldmia.w	sp!, {r4, lr}
 80005cc:	f7ff bf90 	b.w	80004f0 <printf_>
 80005d0:	20000158 	.word	0x20000158
 80005d4:	2000015c 	.word	0x2000015c
 80005d8:	20000164 	.word	0x20000164
 80005dc:	20000160 	.word	0x20000160
 80005e0:	08002760 	.word	0x08002760

080005e4 <lib_os_init>:
 80005e4:	b508      	push	{r3, lr}
 80005e6:	f7ff fe91 	bl	800030c <kernel_init>
 80005ea:	f7ff fee5 	bl	80003b8 <messages_init>
 80005ee:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
 80005f2:	f7ff bfcf 	b.w	8000594 <stdio_init>

080005f6 <mutex_init>:
 80005f6:	b510      	push	{r4, lr}
 80005f8:	4604      	mov	r4, r0
 80005fa:	f7ff fe2f 	bl	800025c <sched_off>
 80005fe:	2300      	movs	r3, #0
 8000600:	6023      	str	r3, [r4, #0]
 8000602:	e8bd 4010 	ldmia.w	sp!, {r4, lr}
 8000606:	f7ff be2b 	b.w	8000260 <sched_on>

0800060a <mutex_lock>:
 800060a:	b513      	push	{r0, r1, r4, lr}
 800060c:	4604      	mov	r4, r0
 800060e:	f7ff fe25 	bl	800025c <sched_off>
 8000612:	6823      	ldr	r3, [r4, #0]
 8000614:	9301      	str	r3, [sp, #4]
 8000616:	f7ff fe23 	bl	8000260 <sched_on>
 800061a:	9b01      	ldr	r3, [sp, #4]
 800061c:	b10b      	cbz	r3, 8000622 <mutex_lock+0x18>
 800061e:	f7ff fe97 	bl	8000350 <set_wait_state>
 8000622:	9b01      	ldr	r3, [sp, #4]
 8000624:	2b00      	cmp	r3, #0
 8000626:	d1f2      	bne.n	800060e <mutex_lock+0x4>
 8000628:	f7ff fe18 	bl	800025c <sched_off>
 800062c:	6823      	ldr	r3, [r4, #0]
 800062e:	9301      	str	r3, [sp, #4]
 8000630:	9b01      	ldr	r3, [sp, #4]
 8000632:	2b00      	cmp	r3, #0
 8000634:	d1eb      	bne.n	800060e <mutex_lock+0x4>
 8000636:	2301      	movs	r3, #1
 8000638:	6023      	str	r3, [r4, #0]
 800063a:	f7ff fe11 	bl	8000260 <sched_on>
 800063e:	b002      	add	sp, #8
 8000640:	bd10      	pop	{r4, pc}

08000642 <mutex_unlock>:
 8000642:	b508      	push	{r3, lr}
 8000644:	f7ff ffd7 	bl	80005f6 <mutex_init>
 8000648:	f7ff fea4 	bl	8000394 <wake_up_threads>
 800064c:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
 8000650:	f7ff be08 	b.w	8000264 <yield>

08000654 <tcp_init>:
 8000654:	4a0f      	ldr	r2, [pc, #60]	; (8000694 <tcp_init+0x40>)
 8000656:	2300      	movs	r3, #0
 8000658:	6013      	str	r3, [r2, #0]
 800065a:	4611      	mov	r1, r2
 800065c:	18c8      	adds	r0, r1, r3
 800065e:	3301      	adds	r3, #1
 8000660:	2200      	movs	r2, #0
 8000662:	2b40      	cmp	r3, #64	; 0x40
 8000664:	7102      	strb	r2, [r0, #4]
 8000666:	d1f9      	bne.n	800065c <tcp_init+0x8>
 8000668:	4b0b      	ldr	r3, [pc, #44]	; (8000698 <tcp_init+0x44>)
 800066a:	490c      	ldr	r1, [pc, #48]	; (800069c <tcp_init+0x48>)
 800066c:	6019      	str	r1, [r3, #0]
 800066e:	490c      	ldr	r1, [pc, #48]	; (80006a0 <tcp_init+0x4c>)
 8000670:	6059      	str	r1, [r3, #4]
 8000672:	490c      	ldr	r1, [pc, #48]	; (80006a4 <tcp_init+0x50>)
 8000674:	6099      	str	r1, [r3, #8]
 8000676:	4907      	ldr	r1, [pc, #28]	; (8000694 <tcp_init+0x40>)
 8000678:	60d9      	str	r1, [r3, #12]
 800067a:	490b      	ldr	r1, [pc, #44]	; (80006a8 <tcp_init+0x54>)
 800067c:	2300      	movs	r3, #0
 800067e:	5453      	strb	r3, [r2, r1]
 8000680:	3201      	adds	r2, #1
 8000682:	2a80      	cmp	r2, #128	; 0x80
 8000684:	d1f9      	bne.n	800067a <tcp_init+0x26>
 8000686:	4a09      	ldr	r2, [pc, #36]	; (80006ac <tcp_init+0x58>)
 8000688:	2100      	movs	r1, #0
 800068a:	5499      	strb	r1, [r3, r2]
 800068c:	3301      	adds	r3, #1
 800068e:	2b80      	cmp	r3, #128	; 0x80
 8000690:	d1f9      	bne.n	8000686 <tcp_init+0x32>
 8000692:	4770      	bx	lr
 8000694:	200006b4 	.word	0x200006b4
 8000698:	200006f8 	.word	0x200006f8
 800069c:	20000198 	.word	0x20000198
 80006a0:	20000620 	.word	0x20000620
 80006a4:	20000168 	.word	0x20000168
 80006a8:	20000634 	.word	0x20000634
 80006ac:	20000708 	.word	0x20000708

080006b0 <tcp_terminal_send>:
 80006b0:	b507      	push	{r0, r1, r2, lr}
 80006b2:	2100      	movs	r1, #0
 80006b4:	4a0c      	ldr	r2, [pc, #48]	; (80006e8 <tcp_terminal_send+0x38>)
 80006b6:	2300      	movs	r3, #0
 80006b8:	548b      	strb	r3, [r1, r2]
 80006ba:	3101      	adds	r1, #1
 80006bc:	2980      	cmp	r1, #128	; 0x80
 80006be:	d1f9      	bne.n	80006b4 <tcp_terminal_send+0x4>
 80006c0:	490a      	ldr	r1, [pc, #40]	; (80006ec <tcp_terminal_send+0x3c>)
 80006c2:	68c8      	ldr	r0, [r1, #12]
 80006c4:	5cc1      	ldrb	r1, [r0, r3]
 80006c6:	54d1      	strb	r1, [r2, r3]
 80006c8:	3301      	adds	r3, #1
 80006ca:	2b44      	cmp	r3, #68	; 0x44
 80006cc:	d1fa      	bne.n	80006c4 <tcp_terminal_send+0x14>
 80006ce:	4b08      	ldr	r3, [pc, #32]	; (80006f0 <tcp_terminal_send+0x40>)
 80006d0:	9300      	str	r3, [sp, #0]
 80006d2:	2380      	movs	r3, #128	; 0x80
 80006d4:	9301      	str	r3, [sp, #4]
 80006d6:	f240 71da 	movw	r1, #2010	; 0x7da
 80006da:	4a03      	ldr	r2, [pc, #12]	; (80006e8 <tcp_terminal_send+0x38>)
 80006dc:	4805      	ldr	r0, [pc, #20]	; (80006f4 <tcp_terminal_send+0x44>)
 80006de:	f000 f8f1 	bl	80008c4 <esp8266_connect>
 80006e2:	b003      	add	sp, #12
 80006e4:	f85d fb04 	ldr.w	pc, [sp], #4
 80006e8:	20000634 	.word	0x20000634
 80006ec:	200006f8 	.word	0x200006f8
 80006f0:	20000708 	.word	0x20000708
 80006f4:	08002771 	.word	0x08002771

080006f8 <tcp_terminal_puts>:
 80006f8:	b570      	push	{r4, r5, r6, lr}
 80006fa:	2300      	movs	r3, #0
 80006fc:	4606      	mov	r6, r0
 80006fe:	4d0b      	ldr	r5, [pc, #44]	; (800072c <tcp_terminal_puts+0x34>)
 8000700:	195a      	adds	r2, r3, r5
 8000702:	3301      	adds	r3, #1
 8000704:	2400      	movs	r4, #0
 8000706:	2b40      	cmp	r3, #64	; 0x40
 8000708:	7114      	strb	r4, [r2, #4]
 800070a:	d1f8      	bne.n	80006fe <tcp_terminal_puts+0x6>
 800070c:	4630      	mov	r0, r6
 800070e:	f7ff fe6d 	bl	80003ec <strlen_>
 8000712:	283f      	cmp	r0, #63	; 0x3f
 8000714:	6028      	str	r0, [r5, #0]
 8000716:	d900      	bls.n	800071a <tcp_terminal_puts+0x22>
 8000718:	bd70      	pop	{r4, r5, r6, pc}
 800071a:	4623      	mov	r3, r4
 800071c:	4283      	cmp	r3, r0
 800071e:	d004      	beq.n	800072a <tcp_terminal_puts+0x32>
 8000720:	18ea      	adds	r2, r5, r3
 8000722:	5cf1      	ldrb	r1, [r6, r3]
 8000724:	7111      	strb	r1, [r2, #4]
 8000726:	3301      	adds	r3, #1
 8000728:	e7f8      	b.n	800071c <tcp_terminal_puts+0x24>
 800072a:	bd70      	pop	{r4, r5, r6, pc}
 800072c:	200006b4 	.word	0x200006b4

08000730 <tcp_send>:
 8000730:	b508      	push	{r3, lr}
 8000732:	f7ff ffbd 	bl	80006b0 <tcp_terminal_send>
 8000736:	b108      	cbz	r0, 800073c <tcp_send+0xc>
 8000738:	f5a0 70c8 	sub.w	r0, r0, #400	; 0x190
 800073c:	bd08      	pop	{r3, pc}

0800073e <esp8266_send>:
 800073e:	b510      	push	{r4, lr}
 8000740:	1e44      	subs	r4, r0, #1
 8000742:	f814 0f01 	ldrb.w	r0, [r4, #1]!
 8000746:	b110      	cbz	r0, 800074e <esp8266_send+0x10>
 8000748:	f001 fc02 	bl	8001f50 <uart_write>
 800074c:	e7f9      	b.n	8000742 <esp8266_send+0x4>
 800074e:	bd10      	pop	{r4, pc}

08000750 <esp8266_send_uint>:
 8000750:	b51f      	push	{r0, r1, r2, r3, r4, lr}
 8000752:	2300      	movs	r3, #0
 8000754:	f88d 300f 	strb.w	r3, [sp, #15]
 8000758:	220a      	movs	r2, #10
 800075a:	230a      	movs	r3, #10
 800075c:	a901      	add	r1, sp, #4
 800075e:	fbb0 f4f3 	udiv	r4, r0, r3
 8000762:	fb03 0314 	mls	r3, r3, r4, r0
 8000766:	3330      	adds	r3, #48	; 0x30
 8000768:	5453      	strb	r3, [r2, r1]
 800076a:	4620      	mov	r0, r4
 800076c:	1e53      	subs	r3, r2, #1
 800076e:	b10c      	cbz	r4, 8000774 <esp8266_send_uint+0x24>
 8000770:	461a      	mov	r2, r3
 8000772:	e7f2      	b.n	800075a <esp8266_send_uint+0xa>
 8000774:	1888      	adds	r0, r1, r2
 8000776:	f7ff ffe2 	bl	800073e <esp8266_send>
 800077a:	b004      	add	sp, #16
 800077c:	bd10      	pop	{r4, pc}

0800077e <esp8266_find_stream>:
 800077e:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
 8000780:	4615      	mov	r5, r2
 8000782:	460f      	mov	r7, r1
 8000784:	4606      	mov	r6, r0
 8000786:	f001 fae9 	bl	8001d5c <timer_get_time>
 800078a:	4405      	add	r5, r0
 800078c:	f001 fc9a 	bl	80020c4 <uart_clear_buffer>
 8000790:	2400      	movs	r4, #0
 8000792:	f001 fbe9 	bl	8001f68 <uart_is_char>
 8000796:	f64f 73ff 	movw	r3, #65535	; 0xffff
 800079a:	4298      	cmp	r0, r3
 800079c:	d00c      	beq.n	80007b8 <esp8266_find_stream+0x3a>
 800079e:	5d33      	ldrb	r3, [r6, r4]
 80007a0:	4283      	cmp	r3, r0
 80007a2:	d108      	bne.n	80007b6 <esp8266_find_stream+0x38>
 80007a4:	1e7b      	subs	r3, r7, #1
 80007a6:	429c      	cmp	r4, r3
 80007a8:	d201      	bcs.n	80007ae <esp8266_find_stream+0x30>
 80007aa:	3401      	adds	r4, #1
 80007ac:	e004      	b.n	80007b8 <esp8266_find_stream+0x3a>
 80007ae:	f001 fc89 	bl	80020c4 <uart_clear_buffer>
 80007b2:	2001      	movs	r0, #1
 80007b4:	bdf8      	pop	{r3, r4, r5, r6, r7, pc}
 80007b6:	2400      	movs	r4, #0
 80007b8:	f001 fad0 	bl	8001d5c <timer_get_time>
 80007bc:	42a8      	cmp	r0, r5
 80007be:	d3e8      	bcc.n	8000792 <esp8266_find_stream+0x14>
 80007c0:	f001 fc80 	bl	80020c4 <uart_clear_buffer>
 80007c4:	2000      	movs	r0, #0
 80007c6:	bdf8      	pop	{r3, r4, r5, r6, r7, pc}

080007c8 <esp8266_init>:
 80007c8:	4b1d      	ldr	r3, [pc, #116]	; (8000840 <esp8266_init+0x78>)
 80007ca:	b510      	push	{r4, lr}
 80007cc:	2200      	movs	r2, #0
 80007ce:	4604      	mov	r4, r0
 80007d0:	f640 30b8 	movw	r0, #3000	; 0xbb8
 80007d4:	601a      	str	r2, [r3, #0]
 80007d6:	f001 facf 	bl	8001d78 <timer_delay_ms>
 80007da:	b10c      	cbz	r4, 80007e0 <esp8266_init+0x18>
 80007dc:	4819      	ldr	r0, [pc, #100]	; (8000844 <esp8266_init+0x7c>)
 80007de:	e000      	b.n	80007e2 <esp8266_init+0x1a>
 80007e0:	4819      	ldr	r0, [pc, #100]	; (8000848 <esp8266_init+0x80>)
 80007e2:	f7ff ffac 	bl	800073e <esp8266_send>
 80007e6:	f44f 707a 	mov.w	r0, #1000	; 0x3e8
 80007ea:	f001 fac5 	bl	8001d78 <timer_delay_ms>
 80007ee:	4817      	ldr	r0, [pc, #92]	; (800084c <esp8266_init+0x84>)
 80007f0:	f7ff ffa5 	bl	800073e <esp8266_send>
 80007f4:	f44f 707a 	mov.w	r0, #1000	; 0x3e8
 80007f8:	f001 fabe 	bl	8001d78 <timer_delay_ms>
 80007fc:	4814      	ldr	r0, [pc, #80]	; (8000850 <esp8266_init+0x88>)
 80007fe:	f7ff ff9e 	bl	800073e <esp8266_send>
 8000802:	4814      	ldr	r0, [pc, #80]	; (8000854 <esp8266_init+0x8c>)
 8000804:	f7ff ff9b 	bl	800073e <esp8266_send>
 8000808:	4813      	ldr	r0, [pc, #76]	; (8000858 <esp8266_init+0x90>)
 800080a:	f7ff ff98 	bl	800073e <esp8266_send>
 800080e:	4813      	ldr	r0, [pc, #76]	; (800085c <esp8266_init+0x94>)
 8000810:	f7ff ff95 	bl	800073e <esp8266_send>
 8000814:	4812      	ldr	r0, [pc, #72]	; (8000860 <esp8266_init+0x98>)
 8000816:	f7ff ff92 	bl	800073e <esp8266_send>
 800081a:	4812      	ldr	r0, [pc, #72]	; (8000864 <esp8266_init+0x9c>)
 800081c:	2102      	movs	r1, #2
 800081e:	f644 6220 	movw	r2, #20000	; 0x4e20
 8000822:	f7ff ffac 	bl	800077e <esp8266_find_stream>
 8000826:	b140      	cbz	r0, 800083a <esp8266_init+0x72>
 8000828:	b12c      	cbz	r4, 8000836 <esp8266_init+0x6e>
 800082a:	480f      	ldr	r0, [pc, #60]	; (8000868 <esp8266_init+0xa0>)
 800082c:	f7ff ff87 	bl	800073e <esp8266_send>
 8000830:	20c8      	movs	r0, #200	; 0xc8
 8000832:	f001 faa1 	bl	8001d78 <timer_delay_ms>
 8000836:	2000      	movs	r0, #0
 8000838:	bd10      	pop	{r4, pc}
 800083a:	f06f 0001 	mvn.w	r0, #1
 800083e:	bd10      	pop	{r4, pc}
 8000840:	20000888 	.word	0x20000888
 8000844:	0800277b 	.word	0x0800277b
 8000848:	08002789 	.word	0x08002789
 800084c:	08002797 	.word	0x08002797
 8000850:	080027a5 	.word	0x080027a5
 8000854:	080027b0 	.word	0x080027b0
 8000858:	080027ff 	.word	0x080027ff
 800085c:	080027ba 	.word	0x080027ba
 8000860:	080027c9 	.word	0x080027c9
 8000864:	08002821 	.word	0x08002821
 8000868:	080027cd 	.word	0x080027cd

0800086c <esp8266_uninit>:
 800086c:	4770      	bx	lr

0800086e <esp8266_get_nonblocking>:
 800086e:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
 8000870:	4615      	mov	r5, r2
 8000872:	4606      	mov	r6, r0
 8000874:	460f      	mov	r7, r1
 8000876:	4603      	mov	r3, r0
 8000878:	1842      	adds	r2, r0, r1
 800087a:	4293      	cmp	r3, r2
 800087c:	f04f 0400 	mov.w	r4, #0
 8000880:	d002      	beq.n	8000888 <esp8266_get_nonblocking+0x1a>
 8000882:	f803 4b01 	strb.w	r4, [r3], #1
 8000886:	e7f8      	b.n	800087a <esp8266_get_nonblocking+0xc>
 8000888:	f001 fa68 	bl	8001d5c <timer_get_time>
 800088c:	4405      	add	r5, r0
 800088e:	f001 fb6b 	bl	8001f68 <uart_is_char>
 8000892:	f64f 73ff 	movw	r3, #65535	; 0xffff
 8000896:	4298      	cmp	r0, r3
 8000898:	bf1c      	itt	ne
 800089a:	5530      	strbne	r0, [r6, r4]
 800089c:	3401      	addne	r4, #1
 800089e:	f001 fa5d 	bl	8001d5c <timer_get_time>
 80008a2:	42bc      	cmp	r4, r7
 80008a4:	d207      	bcs.n	80008b6 <esp8266_get_nonblocking+0x48>
 80008a6:	4285      	cmp	r5, r0
 80008a8:	d8f1      	bhi.n	800088e <esp8266_get_nonblocking+0x20>
 80008aa:	42a8      	cmp	r0, r5
 80008ac:	bf94      	ite	ls
 80008ae:	4620      	movls	r0, r4
 80008b0:	f04f 30ff 	movhi.w	r0, #4294967295	; 0xffffffff
 80008b4:	bdf8      	pop	{r3, r4, r5, r6, r7, pc}
 80008b6:	42a8      	cmp	r0, r5
 80008b8:	bf94      	ite	ls
 80008ba:	f06f 0001 	mvnls.w	r0, #1
 80008be:	f04f 30ff 	movhi.w	r0, #4294967295	; 0xffffffff
 80008c2:	bdf8      	pop	{r3, r4, r5, r6, r7, pc}

080008c4 <esp8266_connect>:
 80008c4:	e92d 43f8 	stmdb	sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
 80008c8:	4f44      	ldr	r7, [pc, #272]	; (80009dc <esp8266_connect+0x118>)
 80008ca:	461e      	mov	r6, r3
 80008cc:	683b      	ldr	r3, [r7, #0]
 80008ce:	2b01      	cmp	r3, #1
 80008d0:	4681      	mov	r9, r0
 80008d2:	4688      	mov	r8, r1
 80008d4:	4614      	mov	r4, r2
 80008d6:	463d      	mov	r5, r7
 80008d8:	d022      	beq.n	8000920 <esp8266_connect+0x5c>
 80008da:	4841      	ldr	r0, [pc, #260]	; (80009e0 <esp8266_connect+0x11c>)
 80008dc:	f7ff ff2f 	bl	800073e <esp8266_send>
 80008e0:	2064      	movs	r0, #100	; 0x64
 80008e2:	f001 fa49 	bl	8001d78 <timer_delay_ms>
 80008e6:	483f      	ldr	r0, [pc, #252]	; (80009e4 <esp8266_connect+0x120>)
 80008e8:	f7ff ff29 	bl	800073e <esp8266_send>
 80008ec:	4648      	mov	r0, r9
 80008ee:	f7ff ff26 	bl	800073e <esp8266_send>
 80008f2:	483d      	ldr	r0, [pc, #244]	; (80009e8 <esp8266_connect+0x124>)
 80008f4:	f7ff ff23 	bl	800073e <esp8266_send>
 80008f8:	4640      	mov	r0, r8
 80008fa:	f7ff ff29 	bl	8000750 <esp8266_send_uint>
 80008fe:	483b      	ldr	r0, [pc, #236]	; (80009ec <esp8266_connect+0x128>)
 8000900:	f7ff ff1d 	bl	800073e <esp8266_send>
 8000904:	483a      	ldr	r0, [pc, #232]	; (80009f0 <esp8266_connect+0x12c>)
 8000906:	2107      	movs	r1, #7
 8000908:	f44f 7261 	mov.w	r2, #900	; 0x384
 800090c:	f7ff ff37 	bl	800077e <esp8266_find_stream>
 8000910:	b920      	cbnz	r0, 800091c <esp8266_connect+0x58>
 8000912:	6038      	str	r0, [r7, #0]
 8000914:	f06f 0002 	mvn.w	r0, #2
 8000918:	e8bd 83f8 	ldmia.w	sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
 800091c:	2301      	movs	r3, #1
 800091e:	603b      	str	r3, [r7, #0]
 8000920:	4834      	ldr	r0, [pc, #208]	; (80009f4 <esp8266_connect+0x130>)
 8000922:	f7ff ff0c 	bl	800073e <esp8266_send>
 8000926:	4630      	mov	r0, r6
 8000928:	f7ff ff12 	bl	8000750 <esp8266_send_uint>
 800092c:	482f      	ldr	r0, [pc, #188]	; (80009ec <esp8266_connect+0x128>)
 800092e:	f7ff ff06 	bl	800073e <esp8266_send>
 8000932:	4831      	ldr	r0, [pc, #196]	; (80009f8 <esp8266_connect+0x134>)
 8000934:	2101      	movs	r1, #1
 8000936:	f44f 727a 	mov.w	r2, #1000	; 0x3e8
 800093a:	f7ff ff20 	bl	800077e <esp8266_find_stream>
 800093e:	4607      	mov	r7, r0
 8000940:	b108      	cbz	r0, 8000946 <esp8266_connect+0x82>
 8000942:	4426      	add	r6, r4
 8000944:	e00a      	b.n	800095c <esp8266_connect+0x98>
 8000946:	4826      	ldr	r0, [pc, #152]	; (80009e0 <esp8266_connect+0x11c>)
 8000948:	f7ff fef9 	bl	800073e <esp8266_send>
 800094c:	2064      	movs	r0, #100	; 0x64
 800094e:	f001 fa13 	bl	8001d78 <timer_delay_ms>
 8000952:	602f      	str	r7, [r5, #0]
 8000954:	f06f 0003 	mvn.w	r0, #3
 8000958:	e8bd 83f8 	ldmia.w	sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
 800095c:	42b4      	cmp	r4, r6
 800095e:	d004      	beq.n	800096a <esp8266_connect+0xa6>
 8000960:	f814 0b01 	ldrb.w	r0, [r4], #1
 8000964:	f001 faf4 	bl	8001f50 <uart_write>
 8000968:	e7f8      	b.n	800095c <esp8266_connect+0x98>
 800096a:	4824      	ldr	r0, [pc, #144]	; (80009fc <esp8266_connect+0x138>)
 800096c:	2107      	movs	r1, #7
 800096e:	f44f 727a 	mov.w	r2, #1000	; 0x3e8
 8000972:	f7ff ff04 	bl	800077e <esp8266_find_stream>
 8000976:	4604      	mov	r4, r0
 8000978:	b950      	cbnz	r0, 8000990 <esp8266_connect+0xcc>
 800097a:	4819      	ldr	r0, [pc, #100]	; (80009e0 <esp8266_connect+0x11c>)
 800097c:	f7ff fedf 	bl	800073e <esp8266_send>
 8000980:	2064      	movs	r0, #100	; 0x64
 8000982:	f001 f9f9 	bl	8001d78 <timer_delay_ms>
 8000986:	602c      	str	r4, [r5, #0]
 8000988:	f06f 0004 	mvn.w	r0, #4
 800098c:	e8bd 83f8 	ldmia.w	sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
 8000990:	481b      	ldr	r0, [pc, #108]	; (8000a00 <esp8266_connect+0x13c>)
 8000992:	2105      	movs	r1, #5
 8000994:	f44f 727a 	mov.w	r2, #1000	; 0x3e8
 8000998:	f7ff fef1 	bl	800077e <esp8266_find_stream>
 800099c:	4604      	mov	r4, r0
 800099e:	b950      	cbnz	r0, 80009b6 <esp8266_connect+0xf2>
 80009a0:	480f      	ldr	r0, [pc, #60]	; (80009e0 <esp8266_connect+0x11c>)
 80009a2:	f7ff fecc 	bl	800073e <esp8266_send>
 80009a6:	2064      	movs	r0, #100	; 0x64
 80009a8:	f001 f9e6 	bl	8001d78 <timer_delay_ms>
 80009ac:	602c      	str	r4, [r5, #0]
 80009ae:	f06f 0005 	mvn.w	r0, #5
 80009b2:	e8bd 83f8 	ldmia.w	sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
 80009b6:	2400      	movs	r4, #0
 80009b8:	f001 faf2 	bl	8001fa0 <uart_read>
 80009bc:	283a      	cmp	r0, #58	; 0x3a
 80009be:	d005      	beq.n	80009cc <esp8266_connect+0x108>
 80009c0:	230a      	movs	r3, #10
 80009c2:	fb03 0004 	mla	r0, r3, r4, r0
 80009c6:	f1a0 0430 	sub.w	r4, r0, #48	; 0x30
 80009ca:	e7f5      	b.n	80009b8 <esp8266_connect+0xf4>
 80009cc:	9808      	ldr	r0, [sp, #32]
 80009ce:	9909      	ldr	r1, [sp, #36]	; 0x24
 80009d0:	2214      	movs	r2, #20
 80009d2:	f7ff ff4c 	bl	800086e <esp8266_get_nonblocking>
 80009d6:	4620      	mov	r0, r4
 80009d8:	e8bd 83f8 	ldmia.w	sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
 80009dc:	20000888 	.word	0x20000888
 80009e0:	080027e1 	.word	0x080027e1
 80009e4:	080027ef 	.word	0x080027ef
 80009e8:	08002803 	.word	0x08002803
 80009ec:	080027ca 	.word	0x080027ca
 80009f0:	08002806 	.word	0x08002806
 80009f4:	0800280e 	.word	0x0800280e
 80009f8:	0800281a 	.word	0x0800281a
 80009fc:	0800281c 	.word	0x0800281c
 8000a00:	08002824 	.word	0x08002824

08000a04 <motors_uninit>:
 8000a04:	b508      	push	{r3, lr}
 8000a06:	20c0      	movs	r0, #192	; 0xc0
 8000a08:	2100      	movs	r1, #0
 8000a0a:	2218      	movs	r2, #24
 8000a0c:	f001 fc50 	bl	80022b0 <i2c_write_reg>
 8000a10:	20c2      	movs	r0, #194	; 0xc2
 8000a12:	2100      	movs	r1, #0
 8000a14:	2218      	movs	r2, #24
 8000a16:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
 8000a1a:	f001 bc49 	b.w	80022b0 <i2c_write_reg>
	...

08000a20 <motors_update>:
 8000a20:	b538      	push	{r3, r4, r5, lr}
 8000a22:	4b41      	ldr	r3, [pc, #260]	; (8000b28 <motors_update+0x108>)
 8000a24:	681c      	ldr	r4, [r3, #0]
 8000a26:	685d      	ldr	r5, [r3, #4]
 8000a28:	b2e4      	uxtb	r4, r4
 8000a2a:	b262      	sxtb	r2, r4
 8000a2c:	b2ed      	uxtb	r5, r5
 8000a2e:	2a2c      	cmp	r2, #44	; 0x2c
 8000a30:	b26b      	sxtb	r3, r5
 8000a32:	dc07      	bgt.n	8000a44 <motors_update+0x24>
 8000a34:	322c      	adds	r2, #44	; 0x2c
 8000a36:	db6e      	blt.n	8000b16 <motors_update+0xf6>
 8000a38:	2b2c      	cmp	r3, #44	; 0x2c
 8000a3a:	dc5d      	bgt.n	8000af8 <motors_update+0xd8>
 8000a3c:	332c      	adds	r3, #44	; 0x2c
 8000a3e:	db34      	blt.n	8000aaa <motors_update+0x8a>
 8000a40:	b1e4      	cbz	r4, 8000a7c <motors_update+0x5c>
 8000a42:	e003      	b.n	8000a4c <motors_update+0x2c>
 8000a44:	242c      	movs	r4, #44	; 0x2c
 8000a46:	42a3      	cmp	r3, r4
 8000a48:	ddf8      	ble.n	8000a3c <motors_update+0x1c>
 8000a4a:	4625      	mov	r5, r4
 8000a4c:	b263      	sxtb	r3, r4
 8000a4e:	2b00      	cmp	r3, #0
 8000a50:	dd08      	ble.n	8000a64 <motors_update+0x44>
 8000a52:	2b05      	cmp	r3, #5
 8000a54:	bfd8      	it	le
 8000a56:	2406      	movle	r4, #6
 8000a58:	b264      	sxtb	r4, r4
 8000a5a:	00a4      	lsls	r4, r4, #2
 8000a5c:	f044 0402 	orr.w	r4, r4, #2
 8000a60:	e00a      	b.n	8000a78 <motors_update+0x58>
 8000a62:	252c      	movs	r5, #44	; 0x2c
 8000a64:	4264      	negs	r4, r4
 8000a66:	b2e4      	uxtb	r4, r4
 8000a68:	2c05      	cmp	r4, #5
 8000a6a:	bf8c      	ite	hi
 8000a6c:	b2e4      	uxtbhi	r4, r4
 8000a6e:	2406      	movls	r4, #6
 8000a70:	b264      	sxtb	r4, r4
 8000a72:	00a4      	lsls	r4, r4, #2
 8000a74:	f044 0401 	orr.w	r4, r4, #1
 8000a78:	b2e4      	uxtb	r4, r4
 8000a7a:	e000      	b.n	8000a7e <motors_update+0x5e>
 8000a7c:	241b      	movs	r4, #27
 8000a7e:	2100      	movs	r1, #0
 8000a80:	460a      	mov	r2, r1
 8000a82:	20c0      	movs	r0, #192	; 0xc0
 8000a84:	f001 fc14 	bl	80022b0 <i2c_write_reg>
 8000a88:	20c0      	movs	r0, #192	; 0xc0
 8000a8a:	2100      	movs	r1, #0
 8000a8c:	4622      	mov	r2, r4
 8000a8e:	f001 fc0f 	bl	80022b0 <i2c_write_reg>
 8000a92:	b315      	cbz	r5, 8000ada <motors_update+0xba>
 8000a94:	b26b      	sxtb	r3, r5
 8000a96:	2b00      	cmp	r3, #0
 8000a98:	dd13      	ble.n	8000ac2 <motors_update+0xa2>
 8000a9a:	2b05      	cmp	r3, #5
 8000a9c:	bfd8      	it	le
 8000a9e:	2506      	movle	r5, #6
 8000aa0:	b26d      	sxtb	r5, r5
 8000aa2:	00ad      	lsls	r5, r5, #2
 8000aa4:	f045 0501 	orr.w	r5, r5, #1
 8000aa8:	e015      	b.n	8000ad6 <motors_update+0xb6>
 8000aaa:	bb1c      	cbnz	r4, 8000af4 <motors_update+0xd4>
 8000aac:	20c0      	movs	r0, #192	; 0xc0
 8000aae:	4621      	mov	r1, r4
 8000ab0:	4622      	mov	r2, r4
 8000ab2:	f001 fbfd 	bl	80022b0 <i2c_write_reg>
 8000ab6:	20c0      	movs	r0, #192	; 0xc0
 8000ab8:	4621      	mov	r1, r4
 8000aba:	221b      	movs	r2, #27
 8000abc:	f001 fbf8 	bl	80022b0 <i2c_write_reg>
 8000ac0:	25d4      	movs	r5, #212	; 0xd4
 8000ac2:	426d      	negs	r5, r5
 8000ac4:	b2ed      	uxtb	r5, r5
 8000ac6:	2d05      	cmp	r5, #5
 8000ac8:	bf8c      	ite	hi
 8000aca:	b2ed      	uxtbhi	r5, r5
 8000acc:	2506      	movls	r5, #6
 8000ace:	b26d      	sxtb	r5, r5
 8000ad0:	00ad      	lsls	r5, r5, #2
 8000ad2:	f045 0502 	orr.w	r5, r5, #2
 8000ad6:	b2ed      	uxtb	r5, r5
 8000ad8:	e000      	b.n	8000adc <motors_update+0xbc>
 8000ada:	251b      	movs	r5, #27
 8000adc:	2100      	movs	r1, #0
 8000ade:	460a      	mov	r2, r1
 8000ae0:	20c2      	movs	r0, #194	; 0xc2
 8000ae2:	f001 fbe5 	bl	80022b0 <i2c_write_reg>
 8000ae6:	462a      	mov	r2, r5
 8000ae8:	20c2      	movs	r0, #194	; 0xc2
 8000aea:	2100      	movs	r1, #0
 8000aec:	e8bd 4038 	ldmia.w	sp!, {r3, r4, r5, lr}
 8000af0:	f001 bbde 	b.w	80022b0 <i2c_write_reg>
 8000af4:	25d4      	movs	r5, #212	; 0xd4
 8000af6:	e7a9      	b.n	8000a4c <motors_update+0x2c>
 8000af8:	b95c      	cbnz	r4, 8000b12 <motors_update+0xf2>
 8000afa:	20c0      	movs	r0, #192	; 0xc0
 8000afc:	4621      	mov	r1, r4
 8000afe:	4622      	mov	r2, r4
 8000b00:	f001 fbd6 	bl	80022b0 <i2c_write_reg>
 8000b04:	20c0      	movs	r0, #192	; 0xc0
 8000b06:	4621      	mov	r1, r4
 8000b08:	221b      	movs	r2, #27
 8000b0a:	f001 fbd1 	bl	80022b0 <i2c_write_reg>
 8000b0e:	252c      	movs	r5, #44	; 0x2c
 8000b10:	e7c6      	b.n	8000aa0 <motors_update+0x80>
 8000b12:	252c      	movs	r5, #44	; 0x2c
 8000b14:	e79a      	b.n	8000a4c <motors_update+0x2c>
 8000b16:	2b2c      	cmp	r3, #44	; 0x2c
 8000b18:	f04f 04d4 	mov.w	r4, #212	; 0xd4
 8000b1c:	dca1      	bgt.n	8000a62 <motors_update+0x42>
 8000b1e:	332d      	adds	r3, #45	; 0x2d
 8000b20:	bfd8      	it	le
 8000b22:	4625      	movle	r5, r4
 8000b24:	e792      	b.n	8000a4c <motors_update+0x2c>
 8000b26:	bf00      	nop
 8000b28:	20000218 	.word	0x20000218

08000b2c <motors_init>:
 8000b2c:	b510      	push	{r4, lr}
 8000b2e:	4b04      	ldr	r3, [pc, #16]	; (8000b40 <motors_init+0x14>)
 8000b30:	2400      	movs	r4, #0
 8000b32:	601c      	str	r4, [r3, #0]
 8000b34:	605c      	str	r4, [r3, #4]
 8000b36:	f7ff ff73 	bl	8000a20 <motors_update>
 8000b3a:	4620      	mov	r0, r4
 8000b3c:	bd10      	pop	{r4, pc}
 8000b3e:	bf00      	nop
 8000b40:	20000218 	.word	0x20000218

08000b44 <m_abs>:
 8000b44:	ee07 0a90 	vmov	s15, r0
 8000b48:	eef5 7ac0 	vcmpe.f32	s15, #0.0
 8000b4c:	eef1 fa10 	vmrs	APSR_nzcv, fpscr
 8000b50:	bf48      	it	mi
 8000b52:	eef1 7a67 	vnegmi.f32	s15, s15
 8000b56:	ee17 0a90 	vmov	r0, s15
 8000b5a:	4770      	bx	lr

08000b5c <m_min>:
 8000b5c:	ee07 0a10 	vmov	s14, r0
 8000b60:	ee07 1a90 	vmov	s15, r1
 8000b64:	eeb4 7ae7 	vcmpe.f32	s14, s15
 8000b68:	eef1 fa10 	vmrs	APSR_nzcv, fpscr
 8000b6c:	bf54      	ite	pl
 8000b6e:	ee17 0a90 	vmovpl	r0, s15
 8000b72:	ee17 0a10 	vmovmi	r0, s14
 8000b76:	4770      	bx	lr

08000b78 <lsm9ds0_uninit>:
 8000b78:	b508      	push	{r3, lr}
 8000b7a:	20d4      	movs	r0, #212	; 0xd4
 8000b7c:	2120      	movs	r1, #32
 8000b7e:	2200      	movs	r2, #0
 8000b80:	f001 fb96 	bl	80022b0 <i2c_write_reg>
 8000b84:	203c      	movs	r0, #60	; 0x3c
 8000b86:	2120      	movs	r1, #32
 8000b88:	2200      	movs	r2, #0
 8000b8a:	f001 fb91 	bl	80022b0 <i2c_write_reg>
 8000b8e:	203c      	movs	r0, #60	; 0x3c
 8000b90:	2124      	movs	r1, #36	; 0x24
 8000b92:	2200      	movs	r2, #0
 8000b94:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
 8000b98:	f001 bb8a 	b.w	80022b0 <i2c_write_reg>

08000b9c <lsm9ds0_read>:
 8000b9c:	b538      	push	{r3, r4, r5, lr}
 8000b9e:	2128      	movs	r1, #40	; 0x28
 8000ba0:	20d4      	movs	r0, #212	; 0xd4
 8000ba2:	f001 fb98 	bl	80022d6 <i2c_read_reg>
 8000ba6:	2129      	movs	r1, #41	; 0x29
 8000ba8:	4604      	mov	r4, r0
 8000baa:	20d4      	movs	r0, #212	; 0xd4
 8000bac:	f001 fb93 	bl	80022d6 <i2c_read_reg>
 8000bb0:	ea44 2000 	orr.w	r0, r4, r0, lsl #8
 8000bb4:	4c43      	ldr	r4, [pc, #268]	; (8000cc4 <lsm9ds0_read+0x128>)
 8000bb6:	b280      	uxth	r0, r0
 8000bb8:	81a0      	strh	r0, [r4, #12]
 8000bba:	89a3      	ldrh	r3, [r4, #12]
 8000bbc:	8a62      	ldrh	r2, [r4, #18]
 8000bbe:	1a9b      	subs	r3, r3, r2
 8000bc0:	b29b      	uxth	r3, r3
 8000bc2:	212a      	movs	r1, #42	; 0x2a
 8000bc4:	20d4      	movs	r0, #212	; 0xd4
 8000bc6:	8323      	strh	r3, [r4, #24]
 8000bc8:	f001 fb85 	bl	80022d6 <i2c_read_reg>
 8000bcc:	212b      	movs	r1, #43	; 0x2b
 8000bce:	4605      	mov	r5, r0
 8000bd0:	20d4      	movs	r0, #212	; 0xd4
 8000bd2:	f001 fb80 	bl	80022d6 <i2c_read_reg>
 8000bd6:	ea45 2000 	orr.w	r0, r5, r0, lsl #8
 8000bda:	b280      	uxth	r0, r0
 8000bdc:	81e0      	strh	r0, [r4, #14]
 8000bde:	89e3      	ldrh	r3, [r4, #14]
 8000be0:	8aa2      	ldrh	r2, [r4, #20]
 8000be2:	1a9b      	subs	r3, r3, r2
 8000be4:	b29b      	uxth	r3, r3
 8000be6:	212c      	movs	r1, #44	; 0x2c
 8000be8:	20d4      	movs	r0, #212	; 0xd4
 8000bea:	8363      	strh	r3, [r4, #26]
 8000bec:	f001 fb73 	bl	80022d6 <i2c_read_reg>
 8000bf0:	212d      	movs	r1, #45	; 0x2d
 8000bf2:	4605      	mov	r5, r0
 8000bf4:	20d4      	movs	r0, #212	; 0xd4
 8000bf6:	f001 fb6e 	bl	80022d6 <i2c_read_reg>
 8000bfa:	ea45 2000 	orr.w	r0, r5, r0, lsl #8
 8000bfe:	b280      	uxth	r0, r0
 8000c00:	8220      	strh	r0, [r4, #16]
 8000c02:	8a23      	ldrh	r3, [r4, #16]
 8000c04:	8ae2      	ldrh	r2, [r4, #22]
 8000c06:	1a9b      	subs	r3, r3, r2
 8000c08:	b29b      	uxth	r3, r3
 8000c0a:	2108      	movs	r1, #8
 8000c0c:	203c      	movs	r0, #60	; 0x3c
 8000c0e:	83a3      	strh	r3, [r4, #28]
 8000c10:	f001 fb61 	bl	80022d6 <i2c_read_reg>
 8000c14:	2109      	movs	r1, #9
 8000c16:	4605      	mov	r5, r0
 8000c18:	203c      	movs	r0, #60	; 0x3c
 8000c1a:	f001 fb5c 	bl	80022d6 <i2c_read_reg>
 8000c1e:	ea45 2000 	orr.w	r0, r5, r0, lsl #8
 8000c22:	b280      	uxth	r0, r0
 8000c24:	80e0      	strh	r0, [r4, #6]
 8000c26:	210a      	movs	r1, #10
 8000c28:	203c      	movs	r0, #60	; 0x3c
 8000c2a:	f001 fb54 	bl	80022d6 <i2c_read_reg>
 8000c2e:	210b      	movs	r1, #11
 8000c30:	4605      	mov	r5, r0
 8000c32:	203c      	movs	r0, #60	; 0x3c
 8000c34:	f001 fb4f 	bl	80022d6 <i2c_read_reg>
 8000c38:	ea45 2000 	orr.w	r0, r5, r0, lsl #8
 8000c3c:	b280      	uxth	r0, r0
 8000c3e:	8120      	strh	r0, [r4, #8]
 8000c40:	210c      	movs	r1, #12
 8000c42:	203c      	movs	r0, #60	; 0x3c
 8000c44:	f001 fb47 	bl	80022d6 <i2c_read_reg>
 8000c48:	210d      	movs	r1, #13
 8000c4a:	4605      	mov	r5, r0
 8000c4c:	203c      	movs	r0, #60	; 0x3c
 8000c4e:	f001 fb42 	bl	80022d6 <i2c_read_reg>
 8000c52:	ea45 2000 	orr.w	r0, r5, r0, lsl #8
 8000c56:	b280      	uxth	r0, r0
 8000c58:	8160      	strh	r0, [r4, #10]
 8000c5a:	2128      	movs	r1, #40	; 0x28
 8000c5c:	203c      	movs	r0, #60	; 0x3c
 8000c5e:	f001 fb3a 	bl	80022d6 <i2c_read_reg>
 8000c62:	2129      	movs	r1, #41	; 0x29
 8000c64:	4605      	mov	r5, r0
 8000c66:	203c      	movs	r0, #60	; 0x3c
 8000c68:	f001 fb35 	bl	80022d6 <i2c_read_reg>
 8000c6c:	ea45 2000 	orr.w	r0, r5, r0, lsl #8
 8000c70:	b280      	uxth	r0, r0
 8000c72:	8020      	strh	r0, [r4, #0]
 8000c74:	212a      	movs	r1, #42	; 0x2a
 8000c76:	203c      	movs	r0, #60	; 0x3c
 8000c78:	f001 fb2d 	bl	80022d6 <i2c_read_reg>
 8000c7c:	212b      	movs	r1, #43	; 0x2b
 8000c7e:	4605      	mov	r5, r0
 8000c80:	203c      	movs	r0, #60	; 0x3c
 8000c82:	f001 fb28 	bl	80022d6 <i2c_read_reg>
 8000c86:	ea45 2000 	orr.w	r0, r5, r0, lsl #8
 8000c8a:	b280      	uxth	r0, r0
 8000c8c:	8060      	strh	r0, [r4, #2]
 8000c8e:	212c      	movs	r1, #44	; 0x2c
 8000c90:	203c      	movs	r0, #60	; 0x3c
 8000c92:	f001 fb20 	bl	80022d6 <i2c_read_reg>
 8000c96:	212d      	movs	r1, #45	; 0x2d
 8000c98:	4605      	mov	r5, r0
 8000c9a:	203c      	movs	r0, #60	; 0x3c
 8000c9c:	f001 fb1b 	bl	80022d6 <i2c_read_reg>
 8000ca0:	ea45 2000 	orr.w	r0, r5, r0, lsl #8
 8000ca4:	b280      	uxth	r0, r0
 8000ca6:	80a0      	strh	r0, [r4, #4]
 8000ca8:	2105      	movs	r1, #5
 8000caa:	203c      	movs	r0, #60	; 0x3c
 8000cac:	f001 fb13 	bl	80022d6 <i2c_read_reg>
 8000cb0:	2106      	movs	r1, #6
 8000cb2:	4605      	mov	r5, r0
 8000cb4:	203c      	movs	r0, #60	; 0x3c
 8000cb6:	f001 fb0e 	bl	80022d6 <i2c_read_reg>
 8000cba:	ea45 2000 	orr.w	r0, r5, r0, lsl #8
 8000cbe:	b280      	uxth	r0, r0
 8000cc0:	85a0      	strh	r0, [r4, #44]	; 0x2c
 8000cc2:	bd38      	pop	{r3, r4, r5, pc}
 8000cc4:	20000168 	.word	0x20000168

08000cc8 <lsm9ds0_calibrate>:
 8000cc8:	e92d 43f8 	stmdb	sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
 8000ccc:	2400      	movs	r4, #0
 8000cce:	4681      	mov	r9, r0
 8000cd0:	4625      	mov	r5, r4
 8000cd2:	4626      	mov	r6, r4
 8000cd4:	46a0      	mov	r8, r4
 8000cd6:	45c8      	cmp	r8, r9
 8000cd8:	4f10      	ldr	r7, [pc, #64]	; (8000d1c <lsm9ds0_calibrate+0x54>)
 8000cda:	d010      	beq.n	8000cfe <lsm9ds0_calibrate+0x36>
 8000cdc:	f7ff ff5e 	bl	8000b9c <lsm9ds0_read>
 8000ce0:	89bb      	ldrh	r3, [r7, #12]
 8000ce2:	fa06 f683 	sxtah	r6, r6, r3
 8000ce6:	89fb      	ldrh	r3, [r7, #14]
 8000ce8:	fa05 f583 	sxtah	r5, r5, r3
 8000cec:	8a3b      	ldrh	r3, [r7, #16]
 8000cee:	200a      	movs	r0, #10
 8000cf0:	fa04 f483 	sxtah	r4, r4, r3
 8000cf4:	f108 0801 	add.w	r8, r8, #1
 8000cf8:	f001 f83e 	bl	8001d78 <timer_delay_ms>
 8000cfc:	e7eb      	b.n	8000cd6 <lsm9ds0_calibrate+0xe>
 8000cfe:	fb96 f6f8 	sdiv	r6, r6, r8
 8000d02:	fb95 f5f8 	sdiv	r5, r5, r8
 8000d06:	b2b6      	uxth	r6, r6
 8000d08:	b2ad      	uxth	r5, r5
 8000d0a:	fb94 f4f8 	sdiv	r4, r4, r8
 8000d0e:	b2a4      	uxth	r4, r4
 8000d10:	827e      	strh	r6, [r7, #18]
 8000d12:	82bd      	strh	r5, [r7, #20]
 8000d14:	82fc      	strh	r4, [r7, #22]
 8000d16:	e8bd 83f8 	ldmia.w	sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
 8000d1a:	bf00      	nop
 8000d1c:	20000168 	.word	0x20000168

08000d20 <lsm9ds0_init>:
 8000d20:	4b29      	ldr	r3, [pc, #164]	; (8000dc8 <lsm9ds0_init+0xa8>)
 8000d22:	b570      	push	{r4, r5, r6, lr}
 8000d24:	210f      	movs	r1, #15
 8000d26:	2400      	movs	r4, #0
 8000d28:	4606      	mov	r6, r0
 8000d2a:	20d4      	movs	r0, #212	; 0xd4
 8000d2c:	801c      	strh	r4, [r3, #0]
 8000d2e:	805c      	strh	r4, [r3, #2]
 8000d30:	809c      	strh	r4, [r3, #4]
 8000d32:	80dc      	strh	r4, [r3, #6]
 8000d34:	811c      	strh	r4, [r3, #8]
 8000d36:	815c      	strh	r4, [r3, #10]
 8000d38:	819c      	strh	r4, [r3, #12]
 8000d3a:	81dc      	strh	r4, [r3, #14]
 8000d3c:	821c      	strh	r4, [r3, #16]
 8000d3e:	831c      	strh	r4, [r3, #24]
 8000d40:	835c      	strh	r4, [r3, #26]
 8000d42:	839c      	strh	r4, [r3, #28]
 8000d44:	859c      	strh	r4, [r3, #44]	; 0x2c
 8000d46:	f001 fac6 	bl	80022d6 <i2c_read_reg>
 8000d4a:	28d4      	cmp	r0, #212	; 0xd4
 8000d4c:	4605      	mov	r5, r0
 8000d4e:	d137      	bne.n	8000dc0 <lsm9ds0_init+0xa0>
 8000d50:	203c      	movs	r0, #60	; 0x3c
 8000d52:	210f      	movs	r1, #15
 8000d54:	f001 fabf 	bl	80022d6 <i2c_read_reg>
 8000d58:	2849      	cmp	r0, #73	; 0x49
 8000d5a:	d133      	bne.n	8000dc4 <lsm9ds0_init+0xa4>
 8000d5c:	4628      	mov	r0, r5
 8000d5e:	2120      	movs	r1, #32
 8000d60:	22ff      	movs	r2, #255	; 0xff
 8000d62:	f001 faa5 	bl	80022b0 <i2c_write_reg>
 8000d66:	4628      	mov	r0, r5
 8000d68:	2123      	movs	r1, #35	; 0x23
 8000d6a:	2218      	movs	r2, #24
 8000d6c:	f001 faa0 	bl	80022b0 <i2c_write_reg>
 8000d70:	203c      	movs	r0, #60	; 0x3c
 8000d72:	211f      	movs	r1, #31
 8000d74:	4622      	mov	r2, r4
 8000d76:	f001 fa9b 	bl	80022b0 <i2c_write_reg>
 8000d7a:	203c      	movs	r0, #60	; 0x3c
 8000d7c:	2120      	movs	r1, #32
 8000d7e:	2267      	movs	r2, #103	; 0x67
 8000d80:	f001 fa96 	bl	80022b0 <i2c_write_reg>
 8000d84:	203c      	movs	r0, #60	; 0x3c
 8000d86:	2121      	movs	r1, #33	; 0x21
 8000d88:	4622      	mov	r2, r4
 8000d8a:	f001 fa91 	bl	80022b0 <i2c_write_reg>
 8000d8e:	203c      	movs	r0, #60	; 0x3c
 8000d90:	2124      	movs	r1, #36	; 0x24
 8000d92:	22f4      	movs	r2, #244	; 0xf4
 8000d94:	f001 fa8c 	bl	80022b0 <i2c_write_reg>
 8000d98:	203c      	movs	r0, #60	; 0x3c
 8000d9a:	2125      	movs	r1, #37	; 0x25
 8000d9c:	4622      	mov	r2, r4
 8000d9e:	f001 fa87 	bl	80022b0 <i2c_write_reg>
 8000da2:	203c      	movs	r0, #60	; 0x3c
 8000da4:	2126      	movs	r1, #38	; 0x26
 8000da6:	2280      	movs	r2, #128	; 0x80
 8000da8:	f001 fa82 	bl	80022b0 <i2c_write_reg>
 8000dac:	f7ff fef6 	bl	8000b9c <lsm9ds0_read>
 8000db0:	b116      	cbz	r6, 8000db8 <lsm9ds0_init+0x98>
 8000db2:	2064      	movs	r0, #100	; 0x64
 8000db4:	f7ff ff88 	bl	8000cc8 <lsm9ds0_calibrate>
 8000db8:	f7ff fef0 	bl	8000b9c <lsm9ds0_read>
 8000dbc:	2000      	movs	r0, #0
 8000dbe:	bd70      	pop	{r4, r5, r6, pc}
 8000dc0:	2001      	movs	r0, #1
 8000dc2:	bd70      	pop	{r4, r5, r6, pc}
 8000dc4:	2002      	movs	r0, #2
 8000dc6:	bd70      	pop	{r4, r5, r6, pc}
 8000dc8:	20000168 	.word	0x20000168

08000dcc <rgb_sensor_uninit>:
 8000dcc:	b508      	push	{r3, lr}
 8000dce:	2008      	movs	r0, #8
 8000dd0:	f001 fbea 	bl	80025a8 <led_off>
 8000dd4:	2072      	movs	r0, #114	; 0x72
 8000dd6:	2180      	movs	r1, #128	; 0x80
 8000dd8:	2200      	movs	r2, #0
 8000dda:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
 8000dde:	f000 bb5b 	b.w	8001498 <rgb_i2c_write_reg>
	...

08000de4 <rgb_sensor_read>:
 8000de4:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
 8000de6:	f000 fad7 	bl	8001398 <rgb_i2cStart>
 8000dea:	2072      	movs	r0, #114	; 0x72
 8000dec:	4d70      	ldr	r5, [pc, #448]	; (8000fb0 <rgb_sensor_read+0x1cc>)
 8000dee:	4c71      	ldr	r4, [pc, #452]	; (8000fb4 <rgb_sensor_read+0x1d0>)
 8000df0:	f000 faf0 	bl	80013d4 <rgb_i2cWrite>
 8000df4:	20b4      	movs	r0, #180	; 0xb4
 8000df6:	f000 faed 	bl	80013d4 <rgb_i2cWrite>
 8000dfa:	f000 facd 	bl	8001398 <rgb_i2cStart>
 8000dfe:	2073      	movs	r0, #115	; 0x73
 8000e00:	f000 fae8 	bl	80013d4 <rgb_i2cWrite>
 8000e04:	2001      	movs	r0, #1
 8000e06:	4629      	mov	r1, r5
 8000e08:	f000 fb04 	bl	8001414 <rgb_i2cRead>
 8000e0c:	782b      	ldrb	r3, [r5, #0]
 8000e0e:	8323      	strh	r3, [r4, #24]
 8000e10:	786b      	ldrb	r3, [r5, #1]
 8000e12:	8363      	strh	r3, [r4, #26]
 8000e14:	78ab      	ldrb	r3, [r5, #2]
 8000e16:	83a3      	strh	r3, [r4, #28]
 8000e18:	2001      	movs	r0, #1
 8000e1a:	78eb      	ldrb	r3, [r5, #3]
 8000e1c:	83e3      	strh	r3, [r4, #30]
 8000e1e:	4629      	mov	r1, r5
 8000e20:	f000 faf8 	bl	8001414 <rgb_i2cRead>
 8000e24:	2300      	movs	r3, #0
 8000e26:	f103 010c 	add.w	r1, r3, #12
 8000e2a:	5ce8      	ldrb	r0, [r5, r3]
 8000e2c:	f834 2011 	ldrh.w	r2, [r4, r1, lsl #1]
 8000e30:	4f60      	ldr	r7, [pc, #384]	; (8000fb4 <rgb_sensor_read+0x1d0>)
 8000e32:	4e5f      	ldr	r6, [pc, #380]	; (8000fb0 <rgb_sensor_read+0x1cc>)
 8000e34:	b292      	uxth	r2, r2
 8000e36:	3301      	adds	r3, #1
 8000e38:	ea42 2200 	orr.w	r2, r2, r0, lsl #8
 8000e3c:	2b04      	cmp	r3, #4
 8000e3e:	f824 2011 	strh.w	r2, [r4, r1, lsl #1]
 8000e42:	d1f0      	bne.n	8000e26 <rgb_sensor_read+0x42>
 8000e44:	2001      	movs	r0, #1
 8000e46:	4631      	mov	r1, r6
 8000e48:	f000 fae4 	bl	8001414 <rgb_i2cRead>
 8000e4c:	7833      	ldrb	r3, [r6, #0]
 8000e4e:	803b      	strh	r3, [r7, #0]
 8000e50:	7873      	ldrb	r3, [r6, #1]
 8000e52:	807b      	strh	r3, [r7, #2]
 8000e54:	78b3      	ldrb	r3, [r6, #2]
 8000e56:	80bb      	strh	r3, [r7, #4]
 8000e58:	2001      	movs	r0, #1
 8000e5a:	78f3      	ldrb	r3, [r6, #3]
 8000e5c:	80fb      	strh	r3, [r7, #6]
 8000e5e:	4631      	mov	r1, r6
 8000e60:	f000 fad8 	bl	8001414 <rgb_i2cRead>
 8000e64:	2300      	movs	r3, #0
 8000e66:	f834 2013 	ldrh.w	r2, [r4, r3, lsl #1]
 8000e6a:	5ce9      	ldrb	r1, [r5, r3]
 8000e6c:	4f51      	ldr	r7, [pc, #324]	; (8000fb4 <rgb_sensor_read+0x1d0>)
 8000e6e:	4e50      	ldr	r6, [pc, #320]	; (8000fb0 <rgb_sensor_read+0x1cc>)
 8000e70:	b292      	uxth	r2, r2
 8000e72:	ea42 2201 	orr.w	r2, r2, r1, lsl #8
 8000e76:	f824 2013 	strh.w	r2, [r4, r3, lsl #1]
 8000e7a:	3301      	adds	r3, #1
 8000e7c:	2b04      	cmp	r3, #4
 8000e7e:	d1f2      	bne.n	8000e66 <rgb_sensor_read+0x82>
 8000e80:	2001      	movs	r0, #1
 8000e82:	4631      	mov	r1, r6
 8000e84:	f000 fac6 	bl	8001414 <rgb_i2cRead>
 8000e88:	7833      	ldrb	r3, [r6, #0]
 8000e8a:	813b      	strh	r3, [r7, #8]
 8000e8c:	7873      	ldrb	r3, [r6, #1]
 8000e8e:	817b      	strh	r3, [r7, #10]
 8000e90:	78b3      	ldrb	r3, [r6, #2]
 8000e92:	81bb      	strh	r3, [r7, #12]
 8000e94:	2001      	movs	r0, #1
 8000e96:	78f3      	ldrb	r3, [r6, #3]
 8000e98:	81fb      	strh	r3, [r7, #14]
 8000e9a:	4631      	mov	r1, r6
 8000e9c:	f000 faba 	bl	8001414 <rgb_i2cRead>
 8000ea0:	2300      	movs	r3, #0
 8000ea2:	1d19      	adds	r1, r3, #4
 8000ea4:	5ce8      	ldrb	r0, [r5, r3]
 8000ea6:	f834 2011 	ldrh.w	r2, [r4, r1, lsl #1]
 8000eaa:	4f42      	ldr	r7, [pc, #264]	; (8000fb4 <rgb_sensor_read+0x1d0>)
 8000eac:	4e40      	ldr	r6, [pc, #256]	; (8000fb0 <rgb_sensor_read+0x1cc>)
 8000eae:	b292      	uxth	r2, r2
 8000eb0:	3301      	adds	r3, #1
 8000eb2:	ea42 2200 	orr.w	r2, r2, r0, lsl #8
 8000eb6:	2b04      	cmp	r3, #4
 8000eb8:	f824 2011 	strh.w	r2, [r4, r1, lsl #1]
 8000ebc:	d1f1      	bne.n	8000ea2 <rgb_sensor_read+0xbe>
 8000ebe:	2001      	movs	r0, #1
 8000ec0:	4631      	mov	r1, r6
 8000ec2:	f000 faa7 	bl	8001414 <rgb_i2cRead>
 8000ec6:	7833      	ldrb	r3, [r6, #0]
 8000ec8:	823b      	strh	r3, [r7, #16]
 8000eca:	7873      	ldrb	r3, [r6, #1]
 8000ecc:	827b      	strh	r3, [r7, #18]
 8000ece:	78b3      	ldrb	r3, [r6, #2]
 8000ed0:	82bb      	strh	r3, [r7, #20]
 8000ed2:	2001      	movs	r0, #1
 8000ed4:	78f3      	ldrb	r3, [r6, #3]
 8000ed6:	82fb      	strh	r3, [r7, #22]
 8000ed8:	4631      	mov	r1, r6
 8000eda:	f000 fa9b 	bl	8001414 <rgb_i2cRead>
 8000ede:	2300      	movs	r3, #0
 8000ee0:	f103 0108 	add.w	r1, r3, #8
 8000ee4:	5ce8      	ldrb	r0, [r5, r3]
 8000ee6:	f834 2011 	ldrh.w	r2, [r4, r1, lsl #1]
 8000eea:	4f32      	ldr	r7, [pc, #200]	; (8000fb4 <rgb_sensor_read+0x1d0>)
 8000eec:	4e30      	ldr	r6, [pc, #192]	; (8000fb0 <rgb_sensor_read+0x1cc>)
 8000eee:	b292      	uxth	r2, r2
 8000ef0:	3301      	adds	r3, #1
 8000ef2:	ea42 2200 	orr.w	r2, r2, r0, lsl #8
 8000ef6:	2b04      	cmp	r3, #4
 8000ef8:	f824 2011 	strh.w	r2, [r4, r1, lsl #1]
 8000efc:	d1f0      	bne.n	8000ee0 <rgb_sensor_read+0xfc>
 8000efe:	2001      	movs	r0, #1
 8000f00:	4631      	mov	r1, r6
 8000f02:	f000 fa87 	bl	8001414 <rgb_i2cRead>
 8000f06:	7833      	ldrb	r3, [r6, #0]
 8000f08:	843b      	strh	r3, [r7, #32]
 8000f0a:	7873      	ldrb	r3, [r6, #1]
 8000f0c:	847b      	strh	r3, [r7, #34]	; 0x22
 8000f0e:	78b3      	ldrb	r3, [r6, #2]
 8000f10:	84bb      	strh	r3, [r7, #36]	; 0x24
 8000f12:	2000      	movs	r0, #0
 8000f14:	78f3      	ldrb	r3, [r6, #3]
 8000f16:	84fb      	strh	r3, [r7, #38]	; 0x26
 8000f18:	4631      	mov	r1, r6
 8000f1a:	f000 fa7b 	bl	8001414 <rgb_i2cRead>
 8000f1e:	2300      	movs	r3, #0
 8000f20:	f103 0110 	add.w	r1, r3, #16
 8000f24:	5ce8      	ldrb	r0, [r5, r3]
 8000f26:	f834 2011 	ldrh.w	r2, [r4, r1, lsl #1]
 8000f2a:	3301      	adds	r3, #1
 8000f2c:	b292      	uxth	r2, r2
 8000f2e:	ea42 2200 	orr.w	r2, r2, r0, lsl #8
 8000f32:	2b04      	cmp	r3, #4
 8000f34:	f824 2011 	strh.w	r2, [r4, r1, lsl #1]
 8000f38:	d1f2      	bne.n	8000f20 <rgb_sensor_read+0x13c>
 8000f3a:	f000 fa3c 	bl	80013b6 <rgb_i2cStop>
 8000f3e:	2300      	movs	r3, #0
 8000f40:	1d1e      	adds	r6, r3, #4
 8000f42:	f834 1013 	ldrh.w	r1, [r4, r3, lsl #1]
 8000f46:	f834 2016 	ldrh.w	r2, [r4, r6, lsl #1]
 8000f4a:	f103 0508 	add.w	r5, r3, #8
 8000f4e:	b212      	sxth	r2, r2
 8000f50:	f834 0015 	ldrh.w	r0, [r4, r5, lsl #1]
 8000f54:	fa02 f281 	sxtah	r2, r2, r1
 8000f58:	f834 1013 	ldrh.w	r1, [r4, r3, lsl #1]
 8000f5c:	fa02 f080 	sxtah	r0, r2, r0
 8000f60:	f103 0734 	add.w	r7, r3, #52	; 0x34
 8000f64:	2264      	movs	r2, #100	; 0x64
 8000f66:	b289      	uxth	r1, r1
 8000f68:	fb11 f102 	smulbb	r1, r1, r2
 8000f6c:	fb91 f1f0 	sdiv	r1, r1, r0
 8000f70:	b289      	uxth	r1, r1
 8000f72:	f824 1017 	strh.w	r1, [r4, r7, lsl #1]
 8000f76:	f834 1016 	ldrh.w	r1, [r4, r6, lsl #1]
 8000f7a:	f103 0638 	add.w	r6, r3, #56	; 0x38
 8000f7e:	b289      	uxth	r1, r1
 8000f80:	fb11 f102 	smulbb	r1, r1, r2
 8000f84:	fb91 f1f0 	sdiv	r1, r1, r0
 8000f88:	b289      	uxth	r1, r1
 8000f8a:	f824 1016 	strh.w	r1, [r4, r6, lsl #1]
 8000f8e:	f834 1015 	ldrh.w	r1, [r4, r5, lsl #1]
 8000f92:	b289      	uxth	r1, r1
 8000f94:	fb11 f202 	smulbb	r2, r1, r2
 8000f98:	f103 013c 	add.w	r1, r3, #60	; 0x3c
 8000f9c:	3301      	adds	r3, #1
 8000f9e:	fb92 f2f0 	sdiv	r2, r2, r0
 8000fa2:	2b04      	cmp	r3, #4
 8000fa4:	b292      	uxth	r2, r2
 8000fa6:	f824 2011 	strh.w	r2, [r4, r1, lsl #1]
 8000faa:	d1c9      	bne.n	8000f40 <rgb_sensor_read+0x15c>
 8000fac:	bdf8      	pop	{r3, r4, r5, r6, r7, pc}
 8000fae:	bf00      	nop
 8000fb0:	2000088c 	.word	0x2000088c
 8000fb4:	20000198 	.word	0x20000198

08000fb8 <rgb_sensor_init>:
 8000fb8:	b537      	push	{r0, r1, r2, r4, r5, lr}
 8000fba:	2300      	movs	r3, #0
 8000fbc:	4a2b      	ldr	r2, [pc, #172]	; (800106c <rgb_sensor_init+0xb4>)
 8000fbe:	1d19      	adds	r1, r3, #4
 8000fc0:	2400      	movs	r4, #0
 8000fc2:	f822 4013 	strh.w	r4, [r2, r3, lsl #1]
 8000fc6:	f822 4011 	strh.w	r4, [r2, r1, lsl #1]
 8000fca:	f103 0108 	add.w	r1, r3, #8
 8000fce:	f822 4011 	strh.w	r4, [r2, r1, lsl #1]
 8000fd2:	f103 0110 	add.w	r1, r3, #16
 8000fd6:	f822 4011 	strh.w	r4, [r2, r1, lsl #1]
 8000fda:	f103 010c 	add.w	r1, r3, #12
 8000fde:	f822 4011 	strh.w	r4, [r2, r1, lsl #1]
 8000fe2:	f103 0134 	add.w	r1, r3, #52	; 0x34
 8000fe6:	f822 4011 	strh.w	r4, [r2, r1, lsl #1]
 8000fea:	f103 0138 	add.w	r1, r3, #56	; 0x38
 8000fee:	f822 4011 	strh.w	r4, [r2, r1, lsl #1]
 8000ff2:	f103 013c 	add.w	r1, r3, #60	; 0x3c
 8000ff6:	3301      	adds	r3, #1
 8000ff8:	2b04      	cmp	r3, #4
 8000ffa:	f822 4011 	strh.w	r4, [r2, r1, lsl #1]
 8000ffe:	d1dd      	bne.n	8000fbc <rgb_sensor_init+0x4>
 8001000:	2008      	movs	r0, #8
 8001002:	f001 fabb 	bl	800257c <led_on>
 8001006:	f000 f997 	bl	8001338 <rgb_i2c_init>
 800100a:	2072      	movs	r0, #114	; 0x72
 800100c:	2181      	movs	r1, #129	; 0x81
 800100e:	22ff      	movs	r2, #255	; 0xff
 8001010:	f000 fa42 	bl	8001498 <rgb_i2c_write_reg>
 8001014:	2072      	movs	r0, #114	; 0x72
 8001016:	2183      	movs	r1, #131	; 0x83
 8001018:	22ff      	movs	r2, #255	; 0xff
 800101a:	f000 fa3d 	bl	8001498 <rgb_i2c_write_reg>
 800101e:	2072      	movs	r0, #114	; 0x72
 8001020:	218d      	movs	r1, #141	; 0x8d
 8001022:	4622      	mov	r2, r4
 8001024:	f000 fa38 	bl	8001498 <rgb_i2c_write_reg>
 8001028:	2072      	movs	r0, #114	; 0x72
 800102a:	2180      	movs	r1, #128	; 0x80
 800102c:	2203      	movs	r2, #3
 800102e:	f000 fa33 	bl	8001498 <rgb_i2c_write_reg>
 8001032:	ad01      	add	r5, sp, #4
 8001034:	2072      	movs	r0, #114	; 0x72
 8001036:	218f      	movs	r1, #143	; 0x8f
 8001038:	2223      	movs	r2, #35	; 0x23
 800103a:	f000 fa2d 	bl	8001498 <rgb_i2c_write_reg>
 800103e:	f7ff fed1 	bl	8000de4 <rgb_sensor_read>
 8001042:	2072      	movs	r0, #114	; 0x72
 8001044:	2192      	movs	r1, #146	; 0x92
 8001046:	462a      	mov	r2, r5
 8001048:	f000 fa39 	bl	80014be <rgb_i2c_read_reg>
 800104c:	4620      	mov	r0, r4
 800104e:	4623      	mov	r3, r4
 8001050:	5cea      	ldrb	r2, [r5, r3]
 8001052:	2a69      	cmp	r2, #105	; 0x69
 8001054:	bf1c      	itt	ne
 8001056:	2201      	movne	r2, #1
 8001058:	409a      	lslne	r2, r3
 800105a:	f103 0301 	add.w	r3, r3, #1
 800105e:	bf18      	it	ne
 8001060:	4310      	orrne	r0, r2
 8001062:	2b04      	cmp	r3, #4
 8001064:	d1f4      	bne.n	8001050 <rgb_sensor_init+0x98>
 8001066:	b003      	add	sp, #12
 8001068:	bd30      	pop	{r4, r5, pc}
 800106a:	bf00      	nop
 800106c:	20000198 	.word	0x20000198

08001070 <rgb_get_line_position>:
 8001070:	4b53      	ldr	r3, [pc, #332]	; (80011c0 <rgb_get_line_position+0x150>)
 8001072:	b5f0      	push	{r4, r5, r6, r7, lr}
 8001074:	cb0f      	ldmia	r3, {r0, r1, r2, r3}
 8001076:	b085      	sub	sp, #20
 8001078:	e88d 000f 	stmia.w	sp, {r0, r1, r2, r3}
 800107c:	2200      	movs	r2, #0
 800107e:	466c      	mov	r4, sp
 8001080:	4615      	mov	r5, r2
 8001082:	4611      	mov	r1, r2
 8001084:	4b4f      	ldr	r3, [pc, #316]	; (80011c4 <rgb_get_line_position+0x154>)
 8001086:	f101 0e0c 	add.w	lr, r1, #12
 800108a:	f101 060a 	add.w	r6, r1, #10
 800108e:	f833 001e 	ldrh.w	r0, [r3, lr, lsl #1]
 8001092:	f853 7026 	ldr.w	r7, [r3, r6, lsl #2]
 8001096:	b200      	sxth	r0, r0
 8001098:	1bc0      	subs	r0, r0, r7
 800109a:	f854 7021 	ldr.w	r7, [r4, r1, lsl #2]
 800109e:	fb07 2200 	mla	r2, r7, r0, r2
 80010a2:	f833 001e 	ldrh.w	r0, [r3, lr, lsl #1]
 80010a6:	f853 6026 	ldr.w	r6, [r3, r6, lsl #2]
 80010aa:	b200      	sxth	r0, r0
 80010ac:	3101      	adds	r1, #1
 80010ae:	1b80      	subs	r0, r0, r6
 80010b0:	2904      	cmp	r1, #4
 80010b2:	4405      	add	r5, r0
 80010b4:	d1e6      	bne.n	8001084 <rgb_get_line_position+0x14>
 80010b6:	4944      	ldr	r1, [pc, #272]	; (80011c8 <rgb_get_line_position+0x158>)
 80010b8:	2d14      	cmp	r5, #20
 80010ba:	f04f 0000 	mov.w	r0, #0
 80010be:	7408      	strb	r0, [r1, #16]
 80010c0:	bfc1      	itttt	gt
 80010c2:	fb92 f2f5 	sdivgt	r2, r2, r5
 80010c6:	2001      	movgt	r0, #1
 80010c8:	3a47      	subgt	r2, #71	; 0x47
 80010ca:	7408      	strbgt	r0, [r1, #16]
 80010cc:	bfc8      	it	gt
 80010ce:	600a      	strgt	r2, [r1, #0]
 80010d0:	2200      	movs	r2, #0
 80010d2:	4616      	mov	r6, r2
 80010d4:	4610      	mov	r0, r2
 80010d6:	f100 0e0e 	add.w	lr, r0, #14
 80010da:	f833 5010 	ldrh.w	r5, [r3, r0, lsl #1]
 80010de:	f853 702e 	ldr.w	r7, [r3, lr, lsl #2]
 80010e2:	b22d      	sxth	r5, r5
 80010e4:	1bed      	subs	r5, r5, r7
 80010e6:	f854 7020 	ldr.w	r7, [r4, r0, lsl #2]
 80010ea:	fb07 2205 	mla	r2, r7, r5, r2
 80010ee:	f833 5010 	ldrh.w	r5, [r3, r0, lsl #1]
 80010f2:	f853 702e 	ldr.w	r7, [r3, lr, lsl #2]
 80010f6:	b22d      	sxth	r5, r5
 80010f8:	3001      	adds	r0, #1
 80010fa:	1bed      	subs	r5, r5, r7
 80010fc:	2804      	cmp	r0, #4
 80010fe:	442e      	add	r6, r5
 8001100:	d1e9      	bne.n	80010d6 <rgb_get_line_position+0x66>
 8001102:	2e28      	cmp	r6, #40	; 0x28
 8001104:	4830      	ldr	r0, [pc, #192]	; (80011c8 <rgb_get_line_position+0x158>)
 8001106:	bfc8      	it	gt
 8001108:	fb92 f2f6 	sdivgt	r2, r2, r6
 800110c:	f04f 0500 	mov.w	r5, #0
 8001110:	744d      	strb	r5, [r1, #17]
 8001112:	bfc1      	itttt	gt
 8001114:	3a47      	subgt	r2, #71	; 0x47
 8001116:	2501      	movgt	r5, #1
 8001118:	7445      	strbgt	r5, [r0, #17]
 800111a:	6042      	strgt	r2, [r0, #4]
 800111c:	2200      	movs	r2, #0
 800111e:	4616      	mov	r6, r2
 8001120:	4610      	mov	r0, r2
 8001122:	f100 0c04 	add.w	ip, r0, #4
 8001126:	f100 0e12 	add.w	lr, r0, #18
 800112a:	f833 501c 	ldrh.w	r5, [r3, ip, lsl #1]
 800112e:	f853 702e 	ldr.w	r7, [r3, lr, lsl #2]
 8001132:	b22d      	sxth	r5, r5
 8001134:	1bed      	subs	r5, r5, r7
 8001136:	f854 7020 	ldr.w	r7, [r4, r0, lsl #2]
 800113a:	fb07 2205 	mla	r2, r7, r5, r2
 800113e:	f833 501c 	ldrh.w	r5, [r3, ip, lsl #1]
 8001142:	f853 702e 	ldr.w	r7, [r3, lr, lsl #2]
 8001146:	b22d      	sxth	r5, r5
 8001148:	3001      	adds	r0, #1
 800114a:	1bed      	subs	r5, r5, r7
 800114c:	2804      	cmp	r0, #4
 800114e:	442e      	add	r6, r5
 8001150:	d1e7      	bne.n	8001122 <rgb_get_line_position+0xb2>
 8001152:	2e0a      	cmp	r6, #10
 8001154:	481c      	ldr	r0, [pc, #112]	; (80011c8 <rgb_get_line_position+0x158>)
 8001156:	bfc8      	it	gt
 8001158:	fb92 f2f6 	sdivgt	r2, r2, r6
 800115c:	f04f 0500 	mov.w	r5, #0
 8001160:	748d      	strb	r5, [r1, #18]
 8001162:	bfc1      	itttt	gt
 8001164:	3a47      	subgt	r2, #71	; 0x47
 8001166:	2501      	movgt	r5, #1
 8001168:	7485      	strbgt	r5, [r0, #18]
 800116a:	6082      	strgt	r2, [r0, #8]
 800116c:	2200      	movs	r2, #0
 800116e:	4616      	mov	r6, r2
 8001170:	4610      	mov	r0, r2
 8001172:	f100 0c08 	add.w	ip, r0, #8
 8001176:	f100 0e16 	add.w	lr, r0, #22
 800117a:	f833 501c 	ldrh.w	r5, [r3, ip, lsl #1]
 800117e:	f853 702e 	ldr.w	r7, [r3, lr, lsl #2]
 8001182:	b22d      	sxth	r5, r5
 8001184:	1bed      	subs	r5, r5, r7
 8001186:	f854 7020 	ldr.w	r7, [r4, r0, lsl #2]
 800118a:	fb07 2205 	mla	r2, r7, r5, r2
 800118e:	f833 501c 	ldrh.w	r5, [r3, ip, lsl #1]
 8001192:	f853 702e 	ldr.w	r7, [r3, lr, lsl #2]
 8001196:	b22d      	sxth	r5, r5
 8001198:	3001      	adds	r0, #1
 800119a:	1bed      	subs	r5, r5, r7
 800119c:	2804      	cmp	r0, #4
 800119e:	442e      	add	r6, r5
 80011a0:	d1e7      	bne.n	8001172 <rgb_get_line_position+0x102>
 80011a2:	2e0a      	cmp	r6, #10
 80011a4:	4b08      	ldr	r3, [pc, #32]	; (80011c8 <rgb_get_line_position+0x158>)
 80011a6:	bfc8      	it	gt
 80011a8:	fb92 f2f6 	sdivgt	r2, r2, r6
 80011ac:	f04f 0000 	mov.w	r0, #0
 80011b0:	74c8      	strb	r0, [r1, #19]
 80011b2:	bfc1      	itttt	gt
 80011b4:	3a47      	subgt	r2, #71	; 0x47
 80011b6:	2101      	movgt	r1, #1
 80011b8:	74d9      	strbgt	r1, [r3, #19]
 80011ba:	60da      	strgt	r2, [r3, #12]
 80011bc:	b005      	add	sp, #20
 80011be:	bdf0      	pop	{r4, r5, r6, r7, pc}
 80011c0:	0800282c 	.word	0x0800282c
 80011c4:	20000198 	.word	0x20000198
 80011c8:	20000620 	.word	0x20000620

080011cc <rgb_set_background>:
 80011cc:	b530      	push	{r4, r5, lr}
 80011ce:	2200      	movs	r2, #0
 80011d0:	4b36      	ldr	r3, [pc, #216]	; (80012ac <rgb_set_background+0xe0>)
 80011d2:	f102 000a 	add.w	r0, r2, #10
 80011d6:	2100      	movs	r1, #0
 80011d8:	f843 1020 	str.w	r1, [r3, r0, lsl #2]
 80011dc:	f102 000e 	add.w	r0, r2, #14
 80011e0:	f843 1020 	str.w	r1, [r3, r0, lsl #2]
 80011e4:	f102 0016 	add.w	r0, r2, #22
 80011e8:	f843 1020 	str.w	r1, [r3, r0, lsl #2]
 80011ec:	f102 0012 	add.w	r0, r2, #18
 80011f0:	3201      	adds	r2, #1
 80011f2:	2a04      	cmp	r2, #4
 80011f4:	f843 1020 	str.w	r1, [r3, r0, lsl #2]
 80011f8:	d1ea      	bne.n	80011d0 <rgb_set_background+0x4>
 80011fa:	2264      	movs	r2, #100	; 0x64
 80011fc:	2100      	movs	r1, #0
 80011fe:	f101 040a 	add.w	r4, r1, #10
 8001202:	f101 000c 	add.w	r0, r1, #12
 8001206:	f833 0010 	ldrh.w	r0, [r3, r0, lsl #1]
 800120a:	f853 5024 	ldr.w	r5, [r3, r4, lsl #2]
 800120e:	fa05 f080 	sxtah	r0, r5, r0
 8001212:	f843 0024 	str.w	r0, [r3, r4, lsl #2]
 8001216:	f101 040e 	add.w	r4, r1, #14
 800121a:	f833 0011 	ldrh.w	r0, [r3, r1, lsl #1]
 800121e:	f853 5024 	ldr.w	r5, [r3, r4, lsl #2]
 8001222:	fa05 f080 	sxtah	r0, r5, r0
 8001226:	f843 0024 	str.w	r0, [r3, r4, lsl #2]
 800122a:	f101 0416 	add.w	r4, r1, #22
 800122e:	1d08      	adds	r0, r1, #4
 8001230:	f833 0010 	ldrh.w	r0, [r3, r0, lsl #1]
 8001234:	f853 5024 	ldr.w	r5, [r3, r4, lsl #2]
 8001238:	fa05 f080 	sxtah	r0, r5, r0
 800123c:	f843 0024 	str.w	r0, [r3, r4, lsl #2]
 8001240:	f101 0412 	add.w	r4, r1, #18
 8001244:	f101 0008 	add.w	r0, r1, #8
 8001248:	3101      	adds	r1, #1
 800124a:	f833 0010 	ldrh.w	r0, [r3, r0, lsl #1]
 800124e:	f853 5024 	ldr.w	r5, [r3, r4, lsl #2]
 8001252:	2904      	cmp	r1, #4
 8001254:	fa05 f080 	sxtah	r0, r5, r0
 8001258:	f843 0024 	str.w	r0, [r3, r4, lsl #2]
 800125c:	d1cf      	bne.n	80011fe <rgb_set_background+0x32>
 800125e:	3a01      	subs	r2, #1
 8001260:	d1cc      	bne.n	80011fc <rgb_set_background+0x30>
 8001262:	f102 040a 	add.w	r4, r2, #10
 8001266:	2164      	movs	r1, #100	; 0x64
 8001268:	f853 0024 	ldr.w	r0, [r3, r4, lsl #2]
 800126c:	fb90 f0f1 	sdiv	r0, r0, r1
 8001270:	f843 0024 	str.w	r0, [r3, r4, lsl #2]
 8001274:	f102 040e 	add.w	r4, r2, #14
 8001278:	f853 0024 	ldr.w	r0, [r3, r4, lsl #2]
 800127c:	fb90 f0f1 	sdiv	r0, r0, r1
 8001280:	f843 0024 	str.w	r0, [r3, r4, lsl #2]
 8001284:	f102 0416 	add.w	r4, r2, #22
 8001288:	f853 0024 	ldr.w	r0, [r3, r4, lsl #2]
 800128c:	fb90 f0f1 	sdiv	r0, r0, r1
 8001290:	f843 0024 	str.w	r0, [r3, r4, lsl #2]
 8001294:	f102 0412 	add.w	r4, r2, #18
 8001298:	3201      	adds	r2, #1
 800129a:	2a04      	cmp	r2, #4
 800129c:	f853 0024 	ldr.w	r0, [r3, r4, lsl #2]
 80012a0:	fb90 f1f1 	sdiv	r1, r0, r1
 80012a4:	f843 1024 	str.w	r1, [r3, r4, lsl #2]
 80012a8:	d1db      	bne.n	8001262 <rgb_set_background+0x96>
 80012aa:	bd30      	pop	{r4, r5, pc}
 80012ac:	20000198 	.word	0x20000198

080012b0 <rgb_i2c_delay>:
 80012b0:	bf00      	nop
 80012b2:	4770      	bx	lr

080012b4 <RGBSetLowSDA>:
 80012b4:	b513      	push	{r0, r1, r4, lr}
 80012b6:	2301      	movs	r3, #1
 80012b8:	2203      	movs	r2, #3
 80012ba:	24f0      	movs	r4, #240	; 0xf0
 80012bc:	f88d 3004 	strb.w	r3, [sp, #4]
 80012c0:	f88d 3006 	strb.w	r3, [sp, #6]
 80012c4:	f04f 4090 	mov.w	r0, #1207959552	; 0x48000000
 80012c8:	2300      	movs	r3, #0
 80012ca:	4669      	mov	r1, sp
 80012cc:	f88d 2005 	strb.w	r2, [sp, #5]
 80012d0:	f88d 3007 	strb.w	r3, [sp, #7]
 80012d4:	9400      	str	r4, [sp, #0]
 80012d6:	f001 f8f2 	bl	80024be <GPIO_Init>
 80012da:	f04f 4390 	mov.w	r3, #1207959552	; 0x48000000
 80012de:	851c      	strh	r4, [r3, #40]	; 0x28
 80012e0:	f7ff ffe6 	bl	80012b0 <rgb_i2c_delay>
 80012e4:	b002      	add	sp, #8
 80012e6:	bd10      	pop	{r4, pc}

080012e8 <RGBSetHighSDA>:
 80012e8:	b513      	push	{r0, r1, r4, lr}
 80012ea:	2300      	movs	r3, #0
 80012ec:	2203      	movs	r2, #3
 80012ee:	24f0      	movs	r4, #240	; 0xf0
 80012f0:	f04f 4090 	mov.w	r0, #1207959552	; 0x48000000
 80012f4:	4669      	mov	r1, sp
 80012f6:	f88d 3004 	strb.w	r3, [sp, #4]
 80012fa:	f88d 2005 	strb.w	r2, [sp, #5]
 80012fe:	f88d 3007 	strb.w	r3, [sp, #7]
 8001302:	9400      	str	r4, [sp, #0]
 8001304:	f001 f8db 	bl	80024be <GPIO_Init>
 8001308:	f04f 4390 	mov.w	r3, #1207959552	; 0x48000000
 800130c:	619c      	str	r4, [r3, #24]
 800130e:	f7ff ffcf 	bl	80012b0 <rgb_i2c_delay>
 8001312:	b002      	add	sp, #8
 8001314:	bd10      	pop	{r4, pc}
	...

08001318 <RGBSetLowSCL>:
 8001318:	4b02      	ldr	r3, [pc, #8]	; (8001324 <RGBSetLowSCL+0xc>)
 800131a:	f44f 5200 	mov.w	r2, #8192	; 0x2000
 800131e:	851a      	strh	r2, [r3, #40]	; 0x28
 8001320:	f7ff bfc6 	b.w	80012b0 <rgb_i2c_delay>
 8001324:	48000800 	.word	0x48000800

08001328 <RGBSetHighSCL>:
 8001328:	4b02      	ldr	r3, [pc, #8]	; (8001334 <RGBSetHighSCL+0xc>)
 800132a:	f44f 5200 	mov.w	r2, #8192	; 0x2000
 800132e:	619a      	str	r2, [r3, #24]
 8001330:	f7ff bfbe 	b.w	80012b0 <rgb_i2c_delay>
 8001334:	48000800 	.word	0x48000800

08001338 <rgb_i2c_init>:
 8001338:	b573      	push	{r0, r1, r4, r5, r6, lr}
 800133a:	f44f 5300 	mov.w	r3, #8192	; 0x2000
 800133e:	2400      	movs	r4, #0
 8001340:	9300      	str	r3, [sp, #0]
 8001342:	2603      	movs	r6, #3
 8001344:	2301      	movs	r3, #1
 8001346:	4669      	mov	r1, sp
 8001348:	4812      	ldr	r0, [pc, #72]	; (8001394 <rgb_i2c_init+0x5c>)
 800134a:	f88d 3004 	strb.w	r3, [sp, #4]
 800134e:	25f0      	movs	r5, #240	; 0xf0
 8001350:	f88d 6005 	strb.w	r6, [sp, #5]
 8001354:	f88d 4006 	strb.w	r4, [sp, #6]
 8001358:	f88d 4007 	strb.w	r4, [sp, #7]
 800135c:	f001 f8af 	bl	80024be <GPIO_Init>
 8001360:	4669      	mov	r1, sp
 8001362:	f04f 4090 	mov.w	r0, #1207959552	; 0x48000000
 8001366:	9500      	str	r5, [sp, #0]
 8001368:	f88d 4004 	strb.w	r4, [sp, #4]
 800136c:	f88d 6005 	strb.w	r6, [sp, #5]
 8001370:	f88d 4007 	strb.w	r4, [sp, #7]
 8001374:	f001 f8a3 	bl	80024be <GPIO_Init>
 8001378:	f04f 4090 	mov.w	r0, #1207959552	; 0x48000000
 800137c:	4629      	mov	r1, r5
 800137e:	f001 f8e0 	bl	8002542 <GPIO_SetBits>
 8001382:	f7ff ffd1 	bl	8001328 <RGBSetHighSCL>
 8001386:	f7ff ff95 	bl	80012b4 <RGBSetLowSDA>
 800138a:	f7ff ffad 	bl	80012e8 <RGBSetHighSDA>
 800138e:	b002      	add	sp, #8
 8001390:	bd70      	pop	{r4, r5, r6, pc}
 8001392:	bf00      	nop
 8001394:	48000800 	.word	0x48000800

08001398 <rgb_i2cStart>:
 8001398:	b508      	push	{r3, lr}
 800139a:	f7ff ffc5 	bl	8001328 <RGBSetHighSCL>
 800139e:	f7ff ffa3 	bl	80012e8 <RGBSetHighSDA>
 80013a2:	f7ff ffc1 	bl	8001328 <RGBSetHighSCL>
 80013a6:	f7ff ff85 	bl	80012b4 <RGBSetLowSDA>
 80013aa:	f7ff ffb5 	bl	8001318 <RGBSetLowSCL>
 80013ae:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
 80013b2:	f7ff bf99 	b.w	80012e8 <RGBSetHighSDA>

080013b6 <rgb_i2cStop>:
 80013b6:	b508      	push	{r3, lr}
 80013b8:	f7ff ffae 	bl	8001318 <RGBSetLowSCL>
 80013bc:	f7ff ff7a 	bl	80012b4 <RGBSetLowSDA>
 80013c0:	f7ff ffb2 	bl	8001328 <RGBSetHighSCL>
 80013c4:	f7ff ff76 	bl	80012b4 <RGBSetLowSDA>
 80013c8:	f7ff ffae 	bl	8001328 <RGBSetHighSCL>
 80013cc:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
 80013d0:	f7ff bf8a 	b.w	80012e8 <RGBSetHighSDA>

080013d4 <rgb_i2cWrite>:
 80013d4:	b538      	push	{r3, r4, r5, lr}
 80013d6:	4605      	mov	r5, r0
 80013d8:	2408      	movs	r4, #8
 80013da:	f7ff ff9d 	bl	8001318 <RGBSetLowSCL>
 80013de:	062b      	lsls	r3, r5, #24
 80013e0:	d502      	bpl.n	80013e8 <rgb_i2cWrite+0x14>
 80013e2:	f7ff ff81 	bl	80012e8 <RGBSetHighSDA>
 80013e6:	e001      	b.n	80013ec <rgb_i2cWrite+0x18>
 80013e8:	f7ff ff64 	bl	80012b4 <RGBSetLowSDA>
 80013ec:	3c01      	subs	r4, #1
 80013ee:	f7ff ff9b 	bl	8001328 <RGBSetHighSCL>
 80013f2:	006d      	lsls	r5, r5, #1
 80013f4:	f014 04ff 	ands.w	r4, r4, #255	; 0xff
 80013f8:	b2ed      	uxtb	r5, r5
 80013fa:	d1ee      	bne.n	80013da <rgb_i2cWrite+0x6>
 80013fc:	f7ff ff8c 	bl	8001318 <RGBSetLowSCL>
 8001400:	f7ff ff72 	bl	80012e8 <RGBSetHighSDA>
 8001404:	f7ff ff90 	bl	8001328 <RGBSetHighSCL>
 8001408:	f7ff ff86 	bl	8001318 <RGBSetLowSCL>
 800140c:	e8bd 4038 	ldmia.w	sp!, {r3, r4, r5, lr}
 8001410:	f7ff bf4e 	b.w	80012b0 <rgb_i2c_delay>

08001414 <rgb_i2cRead>:
 8001414:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
 8001416:	2300      	movs	r3, #0
 8001418:	700b      	strb	r3, [r1, #0]
 800141a:	704b      	strb	r3, [r1, #1]
 800141c:	708b      	strb	r3, [r1, #2]
 800141e:	70cb      	strb	r3, [r1, #3]
 8001420:	4606      	mov	r6, r0
 8001422:	460c      	mov	r4, r1
 8001424:	1ccf      	adds	r7, r1, #3
 8001426:	f7ff ff77 	bl	8001318 <RGBSetLowSCL>
 800142a:	f7ff ff5d 	bl	80012e8 <RGBSetHighSDA>
 800142e:	2508      	movs	r5, #8
 8001430:	1e63      	subs	r3, r4, #1
 8001432:	f813 2f01 	ldrb.w	r2, [r3, #1]!
 8001436:	0052      	lsls	r2, r2, #1
 8001438:	42bb      	cmp	r3, r7
 800143a:	701a      	strb	r2, [r3, #0]
 800143c:	d1f9      	bne.n	8001432 <rgb_i2cRead+0x1e>
 800143e:	f7ff ff73 	bl	8001328 <RGBSetHighSCL>
 8001442:	f04f 4390 	mov.w	r3, #1207959552	; 0x48000000
 8001446:	8a1b      	ldrh	r3, [r3, #16]
 8001448:	b29b      	uxth	r3, r3
 800144a:	06d8      	lsls	r0, r3, #27
 800144c:	bf42      	ittt	mi
 800144e:	7822      	ldrbmi	r2, [r4, #0]
 8001450:	f042 0201 	orrmi.w	r2, r2, #1
 8001454:	7022      	strbmi	r2, [r4, #0]
 8001456:	0699      	lsls	r1, r3, #26
 8001458:	bf42      	ittt	mi
 800145a:	7862      	ldrbmi	r2, [r4, #1]
 800145c:	f042 0201 	orrmi.w	r2, r2, #1
 8001460:	7062      	strbmi	r2, [r4, #1]
 8001462:	065a      	lsls	r2, r3, #25
 8001464:	bf42      	ittt	mi
 8001466:	78a2      	ldrbmi	r2, [r4, #2]
 8001468:	f042 0201 	orrmi.w	r2, r2, #1
 800146c:	70a2      	strbmi	r2, [r4, #2]
 800146e:	061b      	lsls	r3, r3, #24
 8001470:	bf42      	ittt	mi
 8001472:	78e3      	ldrbmi	r3, [r4, #3]
 8001474:	f043 0301 	orrmi.w	r3, r3, #1
 8001478:	70e3      	strbmi	r3, [r4, #3]
 800147a:	f7ff ff4d 	bl	8001318 <RGBSetLowSCL>
 800147e:	3d01      	subs	r5, #1
 8001480:	d1d6      	bne.n	8001430 <rgb_i2cRead+0x1c>
 8001482:	b10e      	cbz	r6, 8001488 <rgb_i2cRead+0x74>
 8001484:	f7ff ff16 	bl	80012b4 <RGBSetLowSDA>
 8001488:	f7ff ff4e 	bl	8001328 <RGBSetHighSCL>
 800148c:	f7ff ff44 	bl	8001318 <RGBSetLowSCL>
 8001490:	e8bd 40f8 	ldmia.w	sp!, {r3, r4, r5, r6, r7, lr}
 8001494:	f7ff bf0c 	b.w	80012b0 <rgb_i2c_delay>

08001498 <rgb_i2c_write_reg>:
 8001498:	b570      	push	{r4, r5, r6, lr}
 800149a:	4606      	mov	r6, r0
 800149c:	460d      	mov	r5, r1
 800149e:	4614      	mov	r4, r2
 80014a0:	f7ff ff7a 	bl	8001398 <rgb_i2cStart>
 80014a4:	4630      	mov	r0, r6
 80014a6:	f7ff ff95 	bl	80013d4 <rgb_i2cWrite>
 80014aa:	4628      	mov	r0, r5
 80014ac:	f7ff ff92 	bl	80013d4 <rgb_i2cWrite>
 80014b0:	4620      	mov	r0, r4
 80014b2:	f7ff ff8f 	bl	80013d4 <rgb_i2cWrite>
 80014b6:	e8bd 4070 	ldmia.w	sp!, {r4, r5, r6, lr}
 80014ba:	f7ff bf7c 	b.w	80013b6 <rgb_i2cStop>

080014be <rgb_i2c_read_reg>:
 80014be:	b570      	push	{r4, r5, r6, lr}
 80014c0:	4604      	mov	r4, r0
 80014c2:	460e      	mov	r6, r1
 80014c4:	4615      	mov	r5, r2
 80014c6:	f7ff ff67 	bl	8001398 <rgb_i2cStart>
 80014ca:	4620      	mov	r0, r4
 80014cc:	f7ff ff82 	bl	80013d4 <rgb_i2cWrite>
 80014d0:	4630      	mov	r0, r6
 80014d2:	f7ff ff7f 	bl	80013d4 <rgb_i2cWrite>
 80014d6:	f7ff ff5f 	bl	8001398 <rgb_i2cStart>
 80014da:	f044 0001 	orr.w	r0, r4, #1
 80014de:	f7ff ff79 	bl	80013d4 <rgb_i2cWrite>
 80014e2:	4629      	mov	r1, r5
 80014e4:	2000      	movs	r0, #0
 80014e6:	f7ff ff95 	bl	8001414 <rgb_i2cRead>
 80014ea:	e8bd 4070 	ldmia.w	sp!, {r4, r5, r6, lr}
 80014ee:	f7ff bf62 	b.w	80013b6 <rgb_i2cStop>
	...

080014f4 <device_sleep>:
 80014f4:	4b01      	ldr	r3, [pc, #4]	; (80014fc <device_sleep+0x8>)
 80014f6:	22ff      	movs	r2, #255	; 0xff
 80014f8:	701a      	strb	r2, [r3, #0]
 80014fa:	4770      	bx	lr
 80014fc:	20000030 	.word	0x20000030

08001500 <device_wake_up>:
 8001500:	4b01      	ldr	r3, [pc, #4]	; (8001508 <device_wake_up+0x8>)
 8001502:	2200      	movs	r2, #0
 8001504:	701a      	strb	r2, [r3, #0]
 8001506:	4770      	bx	lr
 8001508:	20000030 	.word	0x20000030

0800150c <device_i2c_thread>:
 800150c:	b538      	push	{r3, r4, r5, lr}
 800150e:	2000      	movs	r0, #0
 8001510:	210a      	movs	r1, #10
 8001512:	f000 fc41 	bl	8001d98 <event_timer_set_period>
 8001516:	2501      	movs	r5, #1
 8001518:	2400      	movs	r4, #0
 800151a:	2c01      	cmp	r4, #1
 800151c:	d016      	beq.n	800154c <device_i2c_thread+0x40>
 800151e:	d30e      	bcc.n	800153e <device_i2c_thread+0x32>
 8001520:	2c02      	cmp	r4, #2
 8001522:	d1fa      	bne.n	800151a <device_i2c_thread+0xe>
 8001524:	f7ff fb28 	bl	8000b78 <lsm9ds0_uninit>
 8001528:	f7ff fa6c 	bl	8000a04 <motors_uninit>
 800152c:	2064      	movs	r0, #100	; 0x64
 800152e:	f000 fc23 	bl	8001d78 <timer_delay_ms>
 8001532:	4b0d      	ldr	r3, [pc, #52]	; (8001568 <device_i2c_thread+0x5c>)
 8001534:	781b      	ldrb	r3, [r3, #0]
 8001536:	2b00      	cmp	r3, #0
 8001538:	bf08      	it	eq
 800153a:	2400      	moveq	r4, #0
 800153c:	e7ed      	b.n	800151a <device_i2c_thread+0xe>
 800153e:	f7ff faf5 	bl	8000b2c <motors_init>
 8001542:	4628      	mov	r0, r5
 8001544:	f7ff fbec 	bl	8000d20 <lsm9ds0_init>
 8001548:	2500      	movs	r5, #0
 800154a:	2401      	movs	r4, #1
 800154c:	2000      	movs	r0, #0
 800154e:	f000 fc3b 	bl	8001dc8 <event_timer_wait>
 8001552:	f7ff fb23 	bl	8000b9c <lsm9ds0_read>
 8001556:	f7ff fa63 	bl	8000a20 <motors_update>
 800155a:	4b03      	ldr	r3, [pc, #12]	; (8001568 <device_i2c_thread+0x5c>)
 800155c:	781b      	ldrb	r3, [r3, #0]
 800155e:	2b00      	cmp	r3, #0
 8001560:	bf18      	it	ne
 8001562:	2402      	movne	r4, #2
 8001564:	e7d9      	b.n	800151a <device_i2c_thread+0xe>
 8001566:	bf00      	nop
 8001568:	20000030 	.word	0x20000030

0800156c <device_rgb_sensors_thread>:
 800156c:	b510      	push	{r4, lr}
 800156e:	2001      	movs	r0, #1
 8001570:	210a      	movs	r1, #10
 8001572:	f000 fc11 	bl	8001d98 <event_timer_set_period>
 8001576:	2400      	movs	r4, #0
 8001578:	2001      	movs	r0, #1
 800157a:	f000 fc25 	bl	8001dc8 <event_timer_wait>
 800157e:	2c01      	cmp	r4, #1
 8001580:	d019      	beq.n	80015b6 <device_rgb_sensors_thread+0x4a>
 8001582:	d30c      	bcc.n	800159e <device_rgb_sensors_thread+0x32>
 8001584:	2c02      	cmp	r4, #2
 8001586:	d1f7      	bne.n	8001578 <device_rgb_sensors_thread+0xc>
 8001588:	f7ff fc20 	bl	8000dcc <rgb_sensor_uninit>
 800158c:	2064      	movs	r0, #100	; 0x64
 800158e:	f000 fbf3 	bl	8001d78 <timer_delay_ms>
 8001592:	4b0d      	ldr	r3, [pc, #52]	; (80015c8 <device_rgb_sensors_thread+0x5c>)
 8001594:	781b      	ldrb	r3, [r3, #0]
 8001596:	2b00      	cmp	r3, #0
 8001598:	bf08      	it	eq
 800159a:	2400      	moveq	r4, #0
 800159c:	e7ec      	b.n	8001578 <device_rgb_sensors_thread+0xc>
 800159e:	f7ff fd0b 	bl	8000fb8 <rgb_sensor_init>
 80015a2:	4604      	mov	r4, r0
 80015a4:	b128      	cbz	r0, 80015b2 <device_rgb_sensors_thread+0x46>
 80015a6:	f7ff fc11 	bl	8000dcc <rgb_sensor_uninit>
 80015aa:	2001      	movs	r0, #1
 80015ac:	4621      	mov	r1, r4
 80015ae:	f000 f847 	bl	8001640 <abort_error_>
 80015b2:	2401      	movs	r4, #1
 80015b4:	e7e0      	b.n	8001578 <device_rgb_sensors_thread+0xc>
 80015b6:	f7ff fc15 	bl	8000de4 <rgb_sensor_read>
 80015ba:	4b03      	ldr	r3, [pc, #12]	; (80015c8 <device_rgb_sensors_thread+0x5c>)
 80015bc:	781b      	ldrb	r3, [r3, #0]
 80015be:	2b00      	cmp	r3, #0
 80015c0:	d0f7      	beq.n	80015b2 <device_rgb_sensors_thread+0x46>
 80015c2:	2402      	movs	r4, #2
 80015c4:	e7d8      	b.n	8001578 <device_rgb_sensors_thread+0xc>
 80015c6:	bf00      	nop
 80015c8:	20000030 	.word	0x20000030

080015cc <device_wifi_thread>:
 80015cc:	b510      	push	{r4, lr}
 80015ce:	2400      	movs	r4, #0
 80015d0:	2c01      	cmp	r4, #1
 80015d2:	d020      	beq.n	8001616 <device_wifi_thread+0x4a>
 80015d4:	d30c      	bcc.n	80015f0 <device_wifi_thread+0x24>
 80015d6:	2c02      	cmp	r4, #2
 80015d8:	d1fa      	bne.n	80015d0 <device_wifi_thread+0x4>
 80015da:	f7ff f947 	bl	800086c <esp8266_uninit>
 80015de:	2064      	movs	r0, #100	; 0x64
 80015e0:	f000 fbca 	bl	8001d78 <timer_delay_ms>
 80015e4:	4b13      	ldr	r3, [pc, #76]	; (8001634 <device_wifi_thread+0x68>)
 80015e6:	781b      	ldrb	r3, [r3, #0]
 80015e8:	2b00      	cmp	r3, #0
 80015ea:	bf08      	it	eq
 80015ec:	2400      	moveq	r4, #0
 80015ee:	e7ef      	b.n	80015d0 <device_wifi_thread+0x4>
 80015f0:	2001      	movs	r0, #1
 80015f2:	f000 ffc3 	bl	800257c <led_on>
 80015f6:	f7ff f82d 	bl	8000654 <tcp_init>
 80015fa:	2000      	movs	r0, #0
 80015fc:	f7ff f8e4 	bl	80007c8 <esp8266_init>
 8001600:	4604      	mov	r4, r0
 8001602:	b128      	cbz	r0, 8001610 <device_wifi_thread+0x44>
 8001604:	f7ff f932 	bl	800086c <esp8266_uninit>
 8001608:	2003      	movs	r0, #3
 800160a:	4621      	mov	r1, r4
 800160c:	f000 f818 	bl	8001640 <abort_error_>
 8001610:	2064      	movs	r0, #100	; 0x64
 8001612:	f000 fbb1 	bl	8001d78 <timer_delay_ms>
 8001616:	4808      	ldr	r0, [pc, #32]	; (8001638 <device_wifi_thread+0x6c>)
 8001618:	f7ff f86e 	bl	80006f8 <tcp_terminal_puts>
 800161c:	f7ff f888 	bl	8000730 <tcp_send>
 8001620:	2064      	movs	r0, #100	; 0x64
 8001622:	f000 fba9 	bl	8001d78 <timer_delay_ms>
 8001626:	4805      	ldr	r0, [pc, #20]	; (800163c <device_wifi_thread+0x70>)
 8001628:	f7ff f866 	bl	80006f8 <tcp_terminal_puts>
 800162c:	f7ff f880 	bl	8000730 <tcp_send>
 8001630:	e7ee      	b.n	8001610 <device_wifi_thread+0x44>
 8001632:	bf00      	nop
 8001634:	20000030 	.word	0x20000030
 8001638:	0800283c 	.word	0x0800283c
 800163c:	08002852 	.word	0x08002852

08001640 <abort_error_>:
 8001640:	b570      	push	{r4, r5, r6, lr}
 8001642:	4605      	mov	r5, r0
 8001644:	460e      	mov	r6, r1
 8001646:	480d      	ldr	r0, [pc, #52]	; (800167c <abort_error_+0x3c>)
 8001648:	4629      	mov	r1, r5
 800164a:	4632      	mov	r2, r6
 800164c:	f7fe ff50 	bl	80004f0 <printf_>
 8001650:	2408      	movs	r4, #8
 8001652:	f44f 4000 	mov.w	r0, #32768	; 0x8000
 8001656:	f000 ff91 	bl	800257c <led_on>
 800165a:	201e      	movs	r0, #30
 800165c:	f000 fb8c 	bl	8001d78 <timer_delay_ms>
 8001660:	f44f 4000 	mov.w	r0, #32768	; 0x8000
 8001664:	f000 ffa0 	bl	80025a8 <led_off>
 8001668:	2046      	movs	r0, #70	; 0x46
 800166a:	f000 fb85 	bl	8001d78 <timer_delay_ms>
 800166e:	3c01      	subs	r4, #1
 8001670:	d1ef      	bne.n	8001652 <abort_error_+0x12>
 8001672:	f44f 707a 	mov.w	r0, #1000	; 0x3e8
 8001676:	f000 fb7f 	bl	8001d78 <timer_delay_ms>
 800167a:	e7e4      	b.n	8001646 <abort_error_+0x6>
 800167c:	0800286d 	.word	0x0800286d

08001680 <line_follower_test>:
 8001680:	b510      	push	{r4, lr}
 8001682:	ed2d 8b06 	vpush	{d8-d10}
 8001686:	eddf 8a38 	vldr	s17, [pc, #224]	; 8001768 <line_follower_test+0xe8>
 800168a:	4604      	mov	r4, r0
 800168c:	eef0 9a68 	vmov.f32	s19, s17
 8001690:	eeb0 aa68 	vmov.f32	s20, s17
 8001694:	f7ff fcec 	bl	8001070 <rgb_get_line_position>
 8001698:	2c03      	cmp	r4, #3
 800169a:	d81b      	bhi.n	80016d4 <line_follower_test+0x54>
 800169c:	e8df f004 	tbb	[pc, r4]
 80016a0:	0e0a0602 	.word	0x0e0a0602
 80016a4:	4b31      	ldr	r3, [pc, #196]	; (800176c <line_follower_test+0xec>)
 80016a6:	ed93 8a00 	vldr	s16, [r3]
 80016aa:	e00a      	b.n	80016c2 <line_follower_test+0x42>
 80016ac:	4b2f      	ldr	r3, [pc, #188]	; (800176c <line_follower_test+0xec>)
 80016ae:	ed93 8a01 	vldr	s16, [r3, #4]
 80016b2:	e006      	b.n	80016c2 <line_follower_test+0x42>
 80016b4:	4b2d      	ldr	r3, [pc, #180]	; (800176c <line_follower_test+0xec>)
 80016b6:	ed93 8a02 	vldr	s16, [r3, #8]
 80016ba:	e002      	b.n	80016c2 <line_follower_test+0x42>
 80016bc:	4b2b      	ldr	r3, [pc, #172]	; (800176c <line_follower_test+0xec>)
 80016be:	ed93 8a03 	vldr	s16, [r3, #12]
 80016c2:	eddf 7a2b 	vldr	s15, [pc, #172]	; 8001770 <line_follower_test+0xf0>
 80016c6:	eeb8 8ac8 	vcvt.f32.s32	s16, s16
 80016ca:	ee88 8a27 	vdiv.f32	s16, s16, s15
 80016ce:	ee3a 8a48 	vsub.f32	s16, s20, s16
 80016d2:	e001      	b.n	80016d8 <line_follower_test+0x58>
 80016d4:	eeb0 8a68 	vmov.f32	s16, s17
 80016d8:	ed9f 9a26 	vldr	s18, [pc, #152]	; 8001774 <line_follower_test+0xf4>
 80016dc:	eeb4 8ac9 	vcmpe.f32	s16, s18
 80016e0:	eef1 fa10 	vmrs	APSR_nzcv, fpscr
 80016e4:	dc09      	bgt.n	80016fa <line_follower_test+0x7a>
 80016e6:	eddf 7a24 	vldr	s15, [pc, #144]	; 8001778 <line_follower_test+0xf8>
 80016ea:	eeb4 8a67 	vcmp.f32	s16, s15
 80016ee:	eef1 fa10 	vmrs	APSR_nzcv, fpscr
 80016f2:	bf48      	it	mi
 80016f4:	eeb0 8a67 	vmovmi.f32	s16, s15
 80016f8:	e001      	b.n	80016fe <line_follower_test+0x7e>
 80016fa:	eeb0 8a49 	vmov.f32	s16, s18
 80016fe:	ee78 7a68 	vsub.f32	s15, s16, s17
 8001702:	eddf 8a1e 	vldr	s17, [pc, #120]	; 800177c <line_follower_test+0xfc>
 8001706:	ee67 8aa8 	vmul.f32	s17, s15, s17
 800170a:	eddf 7a1d 	vldr	s15, [pc, #116]	; 8001780 <line_follower_test+0x100>
 800170e:	ee18 0a10 	vmov	r0, s16
 8001712:	ee48 8a27 	vmla.f32	s17, s16, s15
 8001716:	f7ff fa15 	bl	8000b44 <m_abs>
 800171a:	ee07 0a90 	vmov	s15, r0
 800171e:	ee39 9a67 	vsub.f32	s18, s18, s15
 8001722:	eddf 7a18 	vldr	s15, [pc, #96]	; 8001784 <line_follower_test+0x104>
 8001726:	ee69 7a27 	vmul.f32	s15, s18, s15
 800172a:	ee17 0a90 	vmov	r0, s15
 800172e:	eddf 7a16 	vldr	s15, [pc, #88]	; 8001788 <line_follower_test+0x108>
 8001732:	ee79 7aa7 	vadd.f32	s15, s19, s15
 8001736:	ee17 1a90 	vmov	r1, s15
 800173a:	f7ff fa0f 	bl	8000b5c <m_min>
 800173e:	ee09 0a90 	vmov	s19, r0
 8001742:	ee79 7aa8 	vadd.f32	s15, s19, s17
 8001746:	ee79 8ae8 	vsub.f32	s17, s19, s17
 800174a:	4b10      	ldr	r3, [pc, #64]	; (800178c <line_follower_test+0x10c>)
 800174c:	eefd 7ae7 	vcvt.s32.f32	s15, s15
 8001750:	eefd 8ae8 	vcvt.s32.f32	s17, s17
 8001754:	200a      	movs	r0, #10
 8001756:	edc3 7a00 	vstr	s15, [r3]
 800175a:	edc3 8a01 	vstr	s17, [r3, #4]
 800175e:	f000 fb0b 	bl	8001d78 <timer_delay_ms>
 8001762:	eef0 8a48 	vmov.f32	s17, s16
 8001766:	e795      	b.n	8001694 <line_follower_test+0x14>
 8001768:	00000000 	.word	0x00000000
 800176c:	20000620 	.word	0x20000620
 8001770:	428c0000 	.word	0x428c0000
 8001774:	3f800000 	.word	0x3f800000
 8001778:	bf800000 	.word	0xbf800000
 800177c:	42c80000 	.word	0x42c80000
 8001780:	42200000 	.word	0x42200000
 8001784:	41a00000 	.word	0x41a00000
 8001788:	3e4ccccd 	.word	0x3e4ccccd
 800178c:	20000218 	.word	0x20000218

08001790 <main_thread>:
 8001790:	b508      	push	{r3, lr}
 8001792:	4823      	ldr	r0, [pc, #140]	; (8001820 <main_thread+0x90>)
 8001794:	f7fe feac 	bl	80004f0 <printf_>
 8001798:	f44f 70fa 	mov.w	r0, #500	; 0x1f4
 800179c:	f000 faec 	bl	8001d78 <timer_delay_ms>
 80017a0:	f7ff feae 	bl	8001500 <device_wake_up>
 80017a4:	491f      	ldr	r1, [pc, #124]	; (8001824 <main_thread+0x94>)
 80017a6:	4820      	ldr	r0, [pc, #128]	; (8001828 <main_thread+0x98>)
 80017a8:	f44f 7200 	mov.w	r2, #512	; 0x200
 80017ac:	2306      	movs	r3, #6
 80017ae:	f7fe fd6d 	bl	800028c <create_thread>
 80017b2:	491e      	ldr	r1, [pc, #120]	; (800182c <main_thread+0x9c>)
 80017b4:	481e      	ldr	r0, [pc, #120]	; (8001830 <main_thread+0xa0>)
 80017b6:	f44f 7200 	mov.w	r2, #512	; 0x200
 80017ba:	2306      	movs	r3, #6
 80017bc:	f7fe fd66 	bl	800028c <create_thread>
 80017c0:	491c      	ldr	r1, [pc, #112]	; (8001834 <main_thread+0xa4>)
 80017c2:	481d      	ldr	r0, [pc, #116]	; (8001838 <main_thread+0xa8>)
 80017c4:	f44f 7200 	mov.w	r2, #512	; 0x200
 80017c8:	2306      	movs	r3, #6
 80017ca:	f7fe fd5f 	bl	800028c <create_thread>
 80017ce:	20c8      	movs	r0, #200	; 0xc8
 80017d0:	f000 fad2 	bl	8001d78 <timer_delay_ms>
 80017d4:	f7ff fcfa 	bl	80011cc <rgb_set_background>
 80017d8:	f000 ff62 	bl	80026a0 <get_key>
 80017dc:	b980      	cbnz	r0, 8001800 <main_thread+0x70>
 80017de:	f44f 4000 	mov.w	r0, #32768	; 0x8000
 80017e2:	f000 fecb 	bl	800257c <led_on>
 80017e6:	2064      	movs	r0, #100	; 0x64
 80017e8:	f000 fac6 	bl	8001d78 <timer_delay_ms>
 80017ec:	f44f 4000 	mov.w	r0, #32768	; 0x8000
 80017f0:	f000 feda 	bl	80025a8 <led_off>
 80017f4:	20c8      	movs	r0, #200	; 0xc8
 80017f6:	f000 fabf 	bl	8001d78 <timer_delay_ms>
 80017fa:	f7ff fe7b 	bl	80014f4 <device_sleep>
 80017fe:	e7eb      	b.n	80017d8 <main_thread+0x48>
 8001800:	f7ff fe7e 	bl	8001500 <device_wake_up>
 8001804:	20c8      	movs	r0, #200	; 0xc8
 8001806:	f000 fab7 	bl	8001d78 <timer_delay_ms>
 800180a:	2001      	movs	r0, #1
 800180c:	f7ff ff38 	bl	8001680 <line_follower_test>
 8001810:	f000 ff46 	bl	80026a0 <get_key>
 8001814:	2800      	cmp	r0, #0
 8001816:	d1df      	bne.n	80017d8 <main_thread+0x48>
 8001818:	f7ff fc2a 	bl	8001070 <rgb_get_line_position>
 800181c:	e7f8      	b.n	8001810 <main_thread+0x80>
 800181e:	bf00      	nop
 8001820:	0800287f 	.word	0x0800287f
 8001824:	20000a90 	.word	0x20000a90
 8001828:	0800156d 	.word	0x0800156d
 800182c:	20000890 	.word	0x20000890
 8001830:	0800150d 	.word	0x0800150d
 8001834:	20000c90 	.word	0x20000c90
 8001838:	080015cd 	.word	0x080015cd

0800183c <main>:
 800183c:	b508      	push	{r3, lr}
 800183e:	f000 fe31 	bl	80024a4 <lib_low_level_init>
 8001842:	f7fe fecf 	bl	80005e4 <lib_os_init>
 8001846:	4905      	ldr	r1, [pc, #20]	; (800185c <main+0x20>)
 8001848:	4805      	ldr	r0, [pc, #20]	; (8001860 <main+0x24>)
 800184a:	f44f 7200 	mov.w	r2, #512	; 0x200
 800184e:	2306      	movs	r3, #6
 8001850:	f7fe fd1c 	bl	800028c <create_thread>
 8001854:	f7fe fd14 	bl	8000280 <kernel_start>
 8001858:	2000      	movs	r0, #0
 800185a:	bd08      	pop	{r3, pc}
 800185c:	20000e90 	.word	0x20000e90
 8001860:	08001791 	.word	0x08001791

08001864 <RCC_GetClocksFreq>:
 8001864:	e92d 41f0 	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
 8001868:	4f9b      	ldr	r7, [pc, #620]	; (8001ad8 <RCC_GetClocksFreq+0x274>)
 800186a:	687b      	ldr	r3, [r7, #4]
 800186c:	f003 030c 	and.w	r3, r3, #12
 8001870:	2b04      	cmp	r3, #4
 8001872:	d005      	beq.n	8001880 <RCC_GetClocksFreq+0x1c>
 8001874:	2b08      	cmp	r3, #8
 8001876:	d006      	beq.n	8001886 <RCC_GetClocksFreq+0x22>
 8001878:	4a98      	ldr	r2, [pc, #608]	; (8001adc <RCC_GetClocksFreq+0x278>)
 800187a:	6002      	str	r2, [r0, #0]
 800187c:	b9b3      	cbnz	r3, 80018ac <RCC_GetClocksFreq+0x48>
 800187e:	e016      	b.n	80018ae <RCC_GetClocksFreq+0x4a>
 8001880:	4b96      	ldr	r3, [pc, #600]	; (8001adc <RCC_GetClocksFreq+0x278>)
 8001882:	6003      	str	r3, [r0, #0]
 8001884:	e012      	b.n	80018ac <RCC_GetClocksFreq+0x48>
 8001886:	687b      	ldr	r3, [r7, #4]
 8001888:	6879      	ldr	r1, [r7, #4]
 800188a:	f3c3 4383 	ubfx	r3, r3, #18, #4
 800188e:	1c9a      	adds	r2, r3, #2
 8001890:	03cb      	lsls	r3, r1, #15
 8001892:	bf49      	itett	mi
 8001894:	6afb      	ldrmi	r3, [r7, #44]	; 0x2c
 8001896:	4b92      	ldrpl	r3, [pc, #584]	; (8001ae0 <RCC_GetClocksFreq+0x27c>)
 8001898:	4990      	ldrmi	r1, [pc, #576]	; (8001adc <RCC_GetClocksFreq+0x278>)
 800189a:	f003 030f 	andmi.w	r3, r3, #15
 800189e:	bf44      	itt	mi
 80018a0:	3301      	addmi	r3, #1
 80018a2:	fbb1 f3f3 	udivmi	r3, r1, r3
 80018a6:	4353      	muls	r3, r2
 80018a8:	6003      	str	r3, [r0, #0]
 80018aa:	e000      	b.n	80018ae <RCC_GetClocksFreq+0x4a>
 80018ac:	2300      	movs	r3, #0
 80018ae:	687a      	ldr	r2, [r7, #4]
 80018b0:	4e8c      	ldr	r6, [pc, #560]	; (8001ae4 <RCC_GetClocksFreq+0x280>)
 80018b2:	f8df c234 	ldr.w	ip, [pc, #564]	; 8001ae8 <RCC_GetClocksFreq+0x284>
 80018b6:	f3c2 1203 	ubfx	r2, r2, #4, #4
 80018ba:	5cb4      	ldrb	r4, [r6, r2]
 80018bc:	6802      	ldr	r2, [r0, #0]
 80018be:	b2e4      	uxtb	r4, r4
 80018c0:	fa22 f104 	lsr.w	r1, r2, r4
 80018c4:	6041      	str	r1, [r0, #4]
 80018c6:	687d      	ldr	r5, [r7, #4]
 80018c8:	f3c5 2502 	ubfx	r5, r5, #8, #3
 80018cc:	5d75      	ldrb	r5, [r6, r5]
 80018ce:	fa21 fe05 	lsr.w	lr, r1, r5
 80018d2:	f8c0 e008 	str.w	lr, [r0, #8]
 80018d6:	687d      	ldr	r5, [r7, #4]
 80018d8:	f3c5 25c2 	ubfx	r5, r5, #11, #3
 80018dc:	5d75      	ldrb	r5, [r6, r5]
 80018de:	b2ed      	uxtb	r5, r5
 80018e0:	40e9      	lsrs	r1, r5
 80018e2:	60c1      	str	r1, [r0, #12]
 80018e4:	6afe      	ldr	r6, [r7, #44]	; 0x2c
 80018e6:	f3c6 1804 	ubfx	r8, r6, #4, #5
 80018ea:	f008 060f 	and.w	r6, r8, #15
 80018ee:	f018 0f10 	tst.w	r8, #16
 80018f2:	f83c 6016 	ldrh.w	r6, [ip, r6, lsl #1]
 80018f6:	46e0      	mov	r8, ip
 80018f8:	b2b6      	uxth	r6, r6
 80018fa:	d004      	beq.n	8001906 <RCC_GetClocksFreq+0xa2>
 80018fc:	b11e      	cbz	r6, 8001906 <RCC_GetClocksFreq+0xa2>
 80018fe:	fbb3 f6f6 	udiv	r6, r3, r6
 8001902:	6106      	str	r6, [r0, #16]
 8001904:	e000      	b.n	8001908 <RCC_GetClocksFreq+0xa4>
 8001906:	6102      	str	r2, [r0, #16]
 8001908:	6afe      	ldr	r6, [r7, #44]	; 0x2c
 800190a:	f3c6 2c44 	ubfx	ip, r6, #9, #5
 800190e:	f00c 060f 	and.w	r6, ip, #15
 8001912:	f01c 0f10 	tst.w	ip, #16
 8001916:	f838 6016 	ldrh.w	r6, [r8, r6, lsl #1]
 800191a:	b2b6      	uxth	r6, r6
 800191c:	d004      	beq.n	8001928 <RCC_GetClocksFreq+0xc4>
 800191e:	b11e      	cbz	r6, 8001928 <RCC_GetClocksFreq+0xc4>
 8001920:	fbb3 f6f6 	udiv	r6, r3, r6
 8001924:	6146      	str	r6, [r0, #20]
 8001926:	e000      	b.n	800192a <RCC_GetClocksFreq+0xc6>
 8001928:	6142      	str	r2, [r0, #20]
 800192a:	6b3e      	ldr	r6, [r7, #48]	; 0x30
 800192c:	06f6      	lsls	r6, r6, #27
 800192e:	bf5a      	itte	pl
 8001930:	4e6a      	ldrpl	r6, [pc, #424]	; (8001adc <RCC_GetClocksFreq+0x278>)
 8001932:	6186      	strpl	r6, [r0, #24]
 8001934:	6182      	strmi	r2, [r0, #24]
 8001936:	6b3e      	ldr	r6, [r7, #48]	; 0x30
 8001938:	06b6      	lsls	r6, r6, #26
 800193a:	bf5a      	itte	pl
 800193c:	4e67      	ldrpl	r6, [pc, #412]	; (8001adc <RCC_GetClocksFreq+0x278>)
 800193e:	61c6      	strpl	r6, [r0, #28]
 8001940:	61c2      	strmi	r2, [r0, #28]
 8001942:	6b3e      	ldr	r6, [r7, #48]	; 0x30
 8001944:	0676      	lsls	r6, r6, #25
 8001946:	bf5a      	itte	pl
 8001948:	4e64      	ldrpl	r6, [pc, #400]	; (8001adc <RCC_GetClocksFreq+0x278>)
 800194a:	6206      	strpl	r6, [r0, #32]
 800194c:	6202      	strmi	r2, [r0, #32]
 800194e:	6b3e      	ldr	r6, [r7, #48]	; 0x30
 8001950:	05f6      	lsls	r6, r6, #23
 8001952:	d506      	bpl.n	8001962 <RCC_GetClocksFreq+0xfe>
 8001954:	429a      	cmp	r2, r3
 8001956:	d104      	bne.n	8001962 <RCC_GetClocksFreq+0xfe>
 8001958:	42a5      	cmp	r5, r4
 800195a:	d102      	bne.n	8001962 <RCC_GetClocksFreq+0xfe>
 800195c:	0056      	lsls	r6, r2, #1
 800195e:	6246      	str	r6, [r0, #36]	; 0x24
 8001960:	e000      	b.n	8001964 <RCC_GetClocksFreq+0x100>
 8001962:	6241      	str	r1, [r0, #36]	; 0x24
 8001964:	6b3e      	ldr	r6, [r7, #48]	; 0x30
 8001966:	04f6      	lsls	r6, r6, #19
 8001968:	d506      	bpl.n	8001978 <RCC_GetClocksFreq+0x114>
 800196a:	429a      	cmp	r2, r3
 800196c:	d104      	bne.n	8001978 <RCC_GetClocksFreq+0x114>
 800196e:	42a5      	cmp	r5, r4
 8001970:	d102      	bne.n	8001978 <RCC_GetClocksFreq+0x114>
 8001972:	0056      	lsls	r6, r2, #1
 8001974:	6286      	str	r6, [r0, #40]	; 0x28
 8001976:	e000      	b.n	800197a <RCC_GetClocksFreq+0x116>
 8001978:	6281      	str	r1, [r0, #40]	; 0x28
 800197a:	6b3e      	ldr	r6, [r7, #48]	; 0x30
 800197c:	05b6      	lsls	r6, r6, #22
 800197e:	d506      	bpl.n	800198e <RCC_GetClocksFreq+0x12a>
 8001980:	429a      	cmp	r2, r3
 8001982:	d104      	bne.n	800198e <RCC_GetClocksFreq+0x12a>
 8001984:	42a5      	cmp	r5, r4
 8001986:	d102      	bne.n	800198e <RCC_GetClocksFreq+0x12a>
 8001988:	0056      	lsls	r6, r2, #1
 800198a:	62c6      	str	r6, [r0, #44]	; 0x2c
 800198c:	e000      	b.n	8001990 <RCC_GetClocksFreq+0x12c>
 800198e:	62c1      	str	r1, [r0, #44]	; 0x2c
 8001990:	6b3e      	ldr	r6, [r7, #48]	; 0x30
 8001992:	0576      	lsls	r6, r6, #21
 8001994:	d506      	bpl.n	80019a4 <RCC_GetClocksFreq+0x140>
 8001996:	429a      	cmp	r2, r3
 8001998:	d104      	bne.n	80019a4 <RCC_GetClocksFreq+0x140>
 800199a:	42a5      	cmp	r5, r4
 800199c:	d102      	bne.n	80019a4 <RCC_GetClocksFreq+0x140>
 800199e:	0056      	lsls	r6, r2, #1
 80019a0:	64c6      	str	r6, [r0, #76]	; 0x4c
 80019a2:	e000      	b.n	80019a6 <RCC_GetClocksFreq+0x142>
 80019a4:	64c1      	str	r1, [r0, #76]	; 0x4c
 80019a6:	6b3e      	ldr	r6, [r7, #48]	; 0x30
 80019a8:	0536      	lsls	r6, r6, #20
 80019aa:	d506      	bpl.n	80019ba <RCC_GetClocksFreq+0x156>
 80019ac:	429a      	cmp	r2, r3
 80019ae:	d104      	bne.n	80019ba <RCC_GetClocksFreq+0x156>
 80019b0:	42a5      	cmp	r5, r4
 80019b2:	d102      	bne.n	80019ba <RCC_GetClocksFreq+0x156>
 80019b4:	0056      	lsls	r6, r2, #1
 80019b6:	6506      	str	r6, [r0, #80]	; 0x50
 80019b8:	e000      	b.n	80019bc <RCC_GetClocksFreq+0x158>
 80019ba:	6501      	str	r1, [r0, #80]	; 0x50
 80019bc:	6b3e      	ldr	r6, [r7, #48]	; 0x30
 80019be:	04b6      	lsls	r6, r6, #18
 80019c0:	d506      	bpl.n	80019d0 <RCC_GetClocksFreq+0x16c>
 80019c2:	429a      	cmp	r2, r3
 80019c4:	d104      	bne.n	80019d0 <RCC_GetClocksFreq+0x16c>
 80019c6:	42a5      	cmp	r5, r4
 80019c8:	d102      	bne.n	80019d0 <RCC_GetClocksFreq+0x16c>
 80019ca:	0056      	lsls	r6, r2, #1
 80019cc:	6546      	str	r6, [r0, #84]	; 0x54
 80019ce:	e000      	b.n	80019d2 <RCC_GetClocksFreq+0x16e>
 80019d0:	6501      	str	r1, [r0, #80]	; 0x50
 80019d2:	6b3e      	ldr	r6, [r7, #48]	; 0x30
 80019d4:	0436      	lsls	r6, r6, #16
 80019d6:	d506      	bpl.n	80019e6 <RCC_GetClocksFreq+0x182>
 80019d8:	429a      	cmp	r2, r3
 80019da:	d104      	bne.n	80019e6 <RCC_GetClocksFreq+0x182>
 80019dc:	42a5      	cmp	r5, r4
 80019de:	d102      	bne.n	80019e6 <RCC_GetClocksFreq+0x182>
 80019e0:	0053      	lsls	r3, r2, #1
 80019e2:	6583      	str	r3, [r0, #88]	; 0x58
 80019e4:	e000      	b.n	80019e8 <RCC_GetClocksFreq+0x184>
 80019e6:	6581      	str	r1, [r0, #88]	; 0x58
 80019e8:	6b3c      	ldr	r4, [r7, #48]	; 0x30
 80019ea:	4b3b      	ldr	r3, [pc, #236]	; (8001ad8 <RCC_GetClocksFreq+0x274>)
 80019ec:	07a4      	lsls	r4, r4, #30
 80019ee:	d101      	bne.n	80019f4 <RCC_GetClocksFreq+0x190>
 80019f0:	6381      	str	r1, [r0, #56]	; 0x38
 80019f2:	e015      	b.n	8001a20 <RCC_GetClocksFreq+0x1bc>
 80019f4:	6b19      	ldr	r1, [r3, #48]	; 0x30
 80019f6:	f001 0103 	and.w	r1, r1, #3
 80019fa:	2901      	cmp	r1, #1
 80019fc:	d101      	bne.n	8001a02 <RCC_GetClocksFreq+0x19e>
 80019fe:	6382      	str	r2, [r0, #56]	; 0x38
 8001a00:	e00e      	b.n	8001a20 <RCC_GetClocksFreq+0x1bc>
 8001a02:	6b19      	ldr	r1, [r3, #48]	; 0x30
 8001a04:	f001 0103 	and.w	r1, r1, #3
 8001a08:	2902      	cmp	r1, #2
 8001a0a:	d102      	bne.n	8001a12 <RCC_GetClocksFreq+0x1ae>
 8001a0c:	f44f 4300 	mov.w	r3, #32768	; 0x8000
 8001a10:	e005      	b.n	8001a1e <RCC_GetClocksFreq+0x1ba>
 8001a12:	6b1b      	ldr	r3, [r3, #48]	; 0x30
 8001a14:	f003 0303 	and.w	r3, r3, #3
 8001a18:	2b03      	cmp	r3, #3
 8001a1a:	d101      	bne.n	8001a20 <RCC_GetClocksFreq+0x1bc>
 8001a1c:	4b2f      	ldr	r3, [pc, #188]	; (8001adc <RCC_GetClocksFreq+0x278>)
 8001a1e:	6383      	str	r3, [r0, #56]	; 0x38
 8001a20:	6b39      	ldr	r1, [r7, #48]	; 0x30
 8001a22:	4b2d      	ldr	r3, [pc, #180]	; (8001ad8 <RCC_GetClocksFreq+0x274>)
 8001a24:	f411 3f40 	tst.w	r1, #196608	; 0x30000
 8001a28:	d102      	bne.n	8001a30 <RCC_GetClocksFreq+0x1cc>
 8001a2a:	f8c0 e03c 	str.w	lr, [r0, #60]	; 0x3c
 8001a2e:	e018      	b.n	8001a62 <RCC_GetClocksFreq+0x1fe>
 8001a30:	6b19      	ldr	r1, [r3, #48]	; 0x30
 8001a32:	f401 3140 	and.w	r1, r1, #196608	; 0x30000
 8001a36:	f5b1 3f80 	cmp.w	r1, #65536	; 0x10000
 8001a3a:	d101      	bne.n	8001a40 <RCC_GetClocksFreq+0x1dc>
 8001a3c:	63c2      	str	r2, [r0, #60]	; 0x3c
 8001a3e:	e010      	b.n	8001a62 <RCC_GetClocksFreq+0x1fe>
 8001a40:	6b19      	ldr	r1, [r3, #48]	; 0x30
 8001a42:	f401 3140 	and.w	r1, r1, #196608	; 0x30000
 8001a46:	f5b1 3f00 	cmp.w	r1, #131072	; 0x20000
 8001a4a:	d102      	bne.n	8001a52 <RCC_GetClocksFreq+0x1ee>
 8001a4c:	f44f 4300 	mov.w	r3, #32768	; 0x8000
 8001a50:	e006      	b.n	8001a60 <RCC_GetClocksFreq+0x1fc>
 8001a52:	6b1b      	ldr	r3, [r3, #48]	; 0x30
 8001a54:	f403 3340 	and.w	r3, r3, #196608	; 0x30000
 8001a58:	f5b3 3f40 	cmp.w	r3, #196608	; 0x30000
 8001a5c:	d101      	bne.n	8001a62 <RCC_GetClocksFreq+0x1fe>
 8001a5e:	4b1f      	ldr	r3, [pc, #124]	; (8001adc <RCC_GetClocksFreq+0x278>)
 8001a60:	63c3      	str	r3, [r0, #60]	; 0x3c
 8001a62:	6b39      	ldr	r1, [r7, #48]	; 0x30
 8001a64:	4b1c      	ldr	r3, [pc, #112]	; (8001ad8 <RCC_GetClocksFreq+0x274>)
 8001a66:	f411 2f40 	tst.w	r1, #786432	; 0xc0000
 8001a6a:	d102      	bne.n	8001a72 <RCC_GetClocksFreq+0x20e>
 8001a6c:	f8c0 e040 	str.w	lr, [r0, #64]	; 0x40
 8001a70:	e018      	b.n	8001aa4 <RCC_GetClocksFreq+0x240>
 8001a72:	6b19      	ldr	r1, [r3, #48]	; 0x30
 8001a74:	f401 2140 	and.w	r1, r1, #786432	; 0xc0000
 8001a78:	f5b1 2f80 	cmp.w	r1, #262144	; 0x40000
 8001a7c:	d101      	bne.n	8001a82 <RCC_GetClocksFreq+0x21e>
 8001a7e:	6402      	str	r2, [r0, #64]	; 0x40
 8001a80:	e010      	b.n	8001aa4 <RCC_GetClocksFreq+0x240>
 8001a82:	6b19      	ldr	r1, [r3, #48]	; 0x30
 8001a84:	f401 2140 	and.w	r1, r1, #786432	; 0xc0000
 8001a88:	f5b1 2f00 	cmp.w	r1, #524288	; 0x80000
 8001a8c:	d102      	bne.n	8001a94 <RCC_GetClocksFreq+0x230>
 8001a8e:	f44f 4300 	mov.w	r3, #32768	; 0x8000
 8001a92:	e006      	b.n	8001aa2 <RCC_GetClocksFreq+0x23e>
 8001a94:	6b1b      	ldr	r3, [r3, #48]	; 0x30
 8001a96:	f403 2340 	and.w	r3, r3, #786432	; 0xc0000
 8001a9a:	f5b3 2f40 	cmp.w	r3, #786432	; 0xc0000
 8001a9e:	d101      	bne.n	8001aa4 <RCC_GetClocksFreq+0x240>
 8001aa0:	4b0e      	ldr	r3, [pc, #56]	; (8001adc <RCC_GetClocksFreq+0x278>)
 8001aa2:	6403      	str	r3, [r0, #64]	; 0x40
 8001aa4:	6b39      	ldr	r1, [r7, #48]	; 0x30
 8001aa6:	4b0c      	ldr	r3, [pc, #48]	; (8001ad8 <RCC_GetClocksFreq+0x274>)
 8001aa8:	f411 1f40 	tst.w	r1, #3145728	; 0x300000
 8001aac:	d102      	bne.n	8001ab4 <RCC_GetClocksFreq+0x250>
 8001aae:	f8c0 e044 	str.w	lr, [r0, #68]	; 0x44
 8001ab2:	e023      	b.n	8001afc <RCC_GetClocksFreq+0x298>
 8001ab4:	6b19      	ldr	r1, [r3, #48]	; 0x30
 8001ab6:	f401 1140 	and.w	r1, r1, #3145728	; 0x300000
 8001aba:	f5b1 1f80 	cmp.w	r1, #1048576	; 0x100000
 8001abe:	d101      	bne.n	8001ac4 <RCC_GetClocksFreq+0x260>
 8001ac0:	6442      	str	r2, [r0, #68]	; 0x44
 8001ac2:	e01b      	b.n	8001afc <RCC_GetClocksFreq+0x298>
 8001ac4:	6b19      	ldr	r1, [r3, #48]	; 0x30
 8001ac6:	f401 1140 	and.w	r1, r1, #3145728	; 0x300000
 8001aca:	f5b1 1f00 	cmp.w	r1, #2097152	; 0x200000
 8001ace:	d10d      	bne.n	8001aec <RCC_GetClocksFreq+0x288>
 8001ad0:	f44f 4300 	mov.w	r3, #32768	; 0x8000
 8001ad4:	e011      	b.n	8001afa <RCC_GetClocksFreq+0x296>
 8001ad6:	bf00      	nop
 8001ad8:	40021000 	.word	0x40021000
 8001adc:	007a1200 	.word	0x007a1200
 8001ae0:	003d0900 	.word	0x003d0900
 8001ae4:	20000020 	.word	0x20000020
 8001ae8:	20000000 	.word	0x20000000
 8001aec:	6b1b      	ldr	r3, [r3, #48]	; 0x30
 8001aee:	f403 1340 	and.w	r3, r3, #3145728	; 0x300000
 8001af2:	f5b3 1f40 	cmp.w	r3, #3145728	; 0x300000
 8001af6:	d101      	bne.n	8001afc <RCC_GetClocksFreq+0x298>
 8001af8:	4b13      	ldr	r3, [pc, #76]	; (8001b48 <RCC_GetClocksFreq+0x2e4>)
 8001afa:	6443      	str	r3, [r0, #68]	; 0x44
 8001afc:	6b39      	ldr	r1, [r7, #48]	; 0x30
 8001afe:	4b13      	ldr	r3, [pc, #76]	; (8001b4c <RCC_GetClocksFreq+0x2e8>)
 8001b00:	f411 0f40 	tst.w	r1, #12582912	; 0xc00000
 8001b04:	d103      	bne.n	8001b0e <RCC_GetClocksFreq+0x2aa>
 8001b06:	f8c0 e048 	str.w	lr, [r0, #72]	; 0x48
 8001b0a:	e8bd 81f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, pc}
 8001b0e:	6b19      	ldr	r1, [r3, #48]	; 0x30
 8001b10:	f401 0140 	and.w	r1, r1, #12582912	; 0xc00000
 8001b14:	f5b1 0f80 	cmp.w	r1, #4194304	; 0x400000
 8001b18:	d102      	bne.n	8001b20 <RCC_GetClocksFreq+0x2bc>
 8001b1a:	6482      	str	r2, [r0, #72]	; 0x48
 8001b1c:	e8bd 81f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, pc}
 8001b20:	6b1a      	ldr	r2, [r3, #48]	; 0x30
 8001b22:	f402 0240 	and.w	r2, r2, #12582912	; 0xc00000
 8001b26:	f5b2 0f00 	cmp.w	r2, #8388608	; 0x800000
 8001b2a:	d102      	bne.n	8001b32 <RCC_GetClocksFreq+0x2ce>
 8001b2c:	f44f 4300 	mov.w	r3, #32768	; 0x8000
 8001b30:	e006      	b.n	8001b40 <RCC_GetClocksFreq+0x2dc>
 8001b32:	6b1b      	ldr	r3, [r3, #48]	; 0x30
 8001b34:	f403 0340 	and.w	r3, r3, #12582912	; 0xc00000
 8001b38:	f5b3 0f40 	cmp.w	r3, #12582912	; 0xc00000
 8001b3c:	d101      	bne.n	8001b42 <RCC_GetClocksFreq+0x2de>
 8001b3e:	4b02      	ldr	r3, [pc, #8]	; (8001b48 <RCC_GetClocksFreq+0x2e4>)
 8001b40:	6483      	str	r3, [r0, #72]	; 0x48
 8001b42:	e8bd 81f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, pc}
 8001b46:	bf00      	nop
 8001b48:	007a1200 	.word	0x007a1200
 8001b4c:	40021000 	.word	0x40021000

08001b50 <RCC_AHBPeriphClockCmd>:
 8001b50:	bf00      	nop
 8001b52:	bf00      	nop
 8001b54:	4b04      	ldr	r3, [pc, #16]	; (8001b68 <RCC_AHBPeriphClockCmd+0x18>)
 8001b56:	695a      	ldr	r2, [r3, #20]
 8001b58:	b109      	cbz	r1, 8001b5e <RCC_AHBPeriphClockCmd+0xe>
 8001b5a:	4310      	orrs	r0, r2
 8001b5c:	e001      	b.n	8001b62 <RCC_AHBPeriphClockCmd+0x12>
 8001b5e:	ea22 0000 	bic.w	r0, r2, r0
 8001b62:	6158      	str	r0, [r3, #20]
 8001b64:	4770      	bx	lr
 8001b66:	bf00      	nop
 8001b68:	40021000 	.word	0x40021000

08001b6c <RCC_APB2PeriphClockCmd>:
 8001b6c:	bf00      	nop
 8001b6e:	bf00      	nop
 8001b70:	4b04      	ldr	r3, [pc, #16]	; (8001b84 <RCC_APB2PeriphClockCmd+0x18>)
 8001b72:	699a      	ldr	r2, [r3, #24]
 8001b74:	b109      	cbz	r1, 8001b7a <RCC_APB2PeriphClockCmd+0xe>
 8001b76:	4310      	orrs	r0, r2
 8001b78:	e001      	b.n	8001b7e <RCC_APB2PeriphClockCmd+0x12>
 8001b7a:	ea22 0000 	bic.w	r0, r2, r0
 8001b7e:	6198      	str	r0, [r3, #24]
 8001b80:	4770      	bx	lr
 8001b82:	bf00      	nop
 8001b84:	40021000 	.word	0x40021000

08001b88 <RCC_APB1PeriphClockCmd>:
 8001b88:	bf00      	nop
 8001b8a:	bf00      	nop
 8001b8c:	4b04      	ldr	r3, [pc, #16]	; (8001ba0 <RCC_APB1PeriphClockCmd+0x18>)
 8001b8e:	69da      	ldr	r2, [r3, #28]
 8001b90:	b109      	cbz	r1, 8001b96 <RCC_APB1PeriphClockCmd+0xe>
 8001b92:	4310      	orrs	r0, r2
 8001b94:	e001      	b.n	8001b9a <RCC_APB1PeriphClockCmd+0x12>
 8001b96:	ea22 0000 	bic.w	r0, r2, r0
 8001b9a:	61d8      	str	r0, [r3, #28]
 8001b9c:	4770      	bx	lr
 8001b9e:	bf00      	nop
 8001ba0:	40021000 	.word	0x40021000

08001ba4 <TIM_TimeBaseInit>:
 8001ba4:	bf00      	nop
 8001ba6:	bf00      	nop
 8001ba8:	bf00      	nop
 8001baa:	4a24      	ldr	r2, [pc, #144]	; (8001c3c <TIM_TimeBaseInit+0x98>)
 8001bac:	8803      	ldrh	r3, [r0, #0]
 8001bae:	4290      	cmp	r0, r2
 8001bb0:	b29b      	uxth	r3, r3
 8001bb2:	d012      	beq.n	8001bda <TIM_TimeBaseInit+0x36>
 8001bb4:	f502 6200 	add.w	r2, r2, #2048	; 0x800
 8001bb8:	4290      	cmp	r0, r2
 8001bba:	d00e      	beq.n	8001bda <TIM_TimeBaseInit+0x36>
 8001bbc:	f1b0 4f80 	cmp.w	r0, #1073741824	; 0x40000000
 8001bc0:	d00b      	beq.n	8001bda <TIM_TimeBaseInit+0x36>
 8001bc2:	f5a2 3298 	sub.w	r2, r2, #77824	; 0x13000
 8001bc6:	4290      	cmp	r0, r2
 8001bc8:	d007      	beq.n	8001bda <TIM_TimeBaseInit+0x36>
 8001bca:	f502 6280 	add.w	r2, r2, #1024	; 0x400
 8001bce:	4290      	cmp	r0, r2
 8001bd0:	d003      	beq.n	8001bda <TIM_TimeBaseInit+0x36>
 8001bd2:	f502 32a4 	add.w	r2, r2, #83968	; 0x14800
 8001bd6:	4290      	cmp	r0, r2
 8001bd8:	d103      	bne.n	8001be2 <TIM_TimeBaseInit+0x3e>
 8001bda:	884a      	ldrh	r2, [r1, #2]
 8001bdc:	f023 0370 	bic.w	r3, r3, #112	; 0x70
 8001be0:	4313      	orrs	r3, r2
 8001be2:	4a17      	ldr	r2, [pc, #92]	; (8001c40 <TIM_TimeBaseInit+0x9c>)
 8001be4:	4290      	cmp	r0, r2
 8001be6:	d008      	beq.n	8001bfa <TIM_TimeBaseInit+0x56>
 8001be8:	f502 6280 	add.w	r2, r2, #1024	; 0x400
 8001bec:	4290      	cmp	r0, r2
 8001bee:	bf1f      	itttt	ne
 8001bf0:	f423 7340 	bicne.w	r3, r3, #768	; 0x300
 8001bf4:	890a      	ldrhne	r2, [r1, #8]
 8001bf6:	b29b      	uxthne	r3, r3
 8001bf8:	4313      	orrne	r3, r2
 8001bfa:	8003      	strh	r3, [r0, #0]
 8001bfc:	684b      	ldr	r3, [r1, #4]
 8001bfe:	62c3      	str	r3, [r0, #44]	; 0x2c
 8001c00:	880b      	ldrh	r3, [r1, #0]
 8001c02:	8503      	strh	r3, [r0, #40]	; 0x28
 8001c04:	4b0d      	ldr	r3, [pc, #52]	; (8001c3c <TIM_TimeBaseInit+0x98>)
 8001c06:	4298      	cmp	r0, r3
 8001c08:	d013      	beq.n	8001c32 <TIM_TimeBaseInit+0x8e>
 8001c0a:	f503 6300 	add.w	r3, r3, #2048	; 0x800
 8001c0e:	4298      	cmp	r0, r3
 8001c10:	d00f      	beq.n	8001c32 <TIM_TimeBaseInit+0x8e>
 8001c12:	f503 6340 	add.w	r3, r3, #3072	; 0xc00
 8001c16:	4298      	cmp	r0, r3
 8001c18:	d00b      	beq.n	8001c32 <TIM_TimeBaseInit+0x8e>
 8001c1a:	f503 6380 	add.w	r3, r3, #1024	; 0x400
 8001c1e:	4298      	cmp	r0, r3
 8001c20:	d007      	beq.n	8001c32 <TIM_TimeBaseInit+0x8e>
 8001c22:	f503 6380 	add.w	r3, r3, #1024	; 0x400
 8001c26:	4298      	cmp	r0, r3
 8001c28:	d003      	beq.n	8001c32 <TIM_TimeBaseInit+0x8e>
 8001c2a:	f503 6300 	add.w	r3, r3, #2048	; 0x800
 8001c2e:	4298      	cmp	r0, r3
 8001c30:	d101      	bne.n	8001c36 <TIM_TimeBaseInit+0x92>
 8001c32:	894b      	ldrh	r3, [r1, #10]
 8001c34:	8603      	strh	r3, [r0, #48]	; 0x30
 8001c36:	2301      	movs	r3, #1
 8001c38:	6143      	str	r3, [r0, #20]
 8001c3a:	4770      	bx	lr
 8001c3c:	40012c00 	.word	0x40012c00
 8001c40:	40001000 	.word	0x40001000

08001c44 <TIM_Cmd>:
 8001c44:	bf00      	nop
 8001c46:	bf00      	nop
 8001c48:	8803      	ldrh	r3, [r0, #0]
 8001c4a:	b119      	cbz	r1, 8001c54 <TIM_Cmd+0x10>
 8001c4c:	b29b      	uxth	r3, r3
 8001c4e:	f043 0301 	orr.w	r3, r3, #1
 8001c52:	e003      	b.n	8001c5c <TIM_Cmd+0x18>
 8001c54:	f023 0301 	bic.w	r3, r3, #1
 8001c58:	041b      	lsls	r3, r3, #16
 8001c5a:	0c1b      	lsrs	r3, r3, #16
 8001c5c:	8003      	strh	r3, [r0, #0]
 8001c5e:	4770      	bx	lr

08001c60 <TIM_ClearITPendingBit>:
 8001c60:	bf00      	nop
 8001c62:	43c9      	mvns	r1, r1
 8001c64:	b289      	uxth	r1, r1
 8001c66:	6101      	str	r1, [r0, #16]
 8001c68:	4770      	bx	lr
	...

08001c6c <timer_init>:
 8001c6c:	b530      	push	{r4, r5, lr}
 8001c6e:	2300      	movs	r3, #0
 8001c70:	b085      	sub	sp, #20
 8001c72:	491f      	ldr	r1, [pc, #124]	; (8001cf0 <timer_init+0x84>)
 8001c74:	f44f 6280 	mov.w	r2, #1024	; 0x400
 8001c78:	f821 2013 	strh.w	r2, [r1, r3, lsl #1]
 8001c7c:	491d      	ldr	r1, [pc, #116]	; (8001cf4 <timer_init+0x88>)
 8001c7e:	f821 2013 	strh.w	r2, [r1, r3, lsl #1]
 8001c82:	4a1d      	ldr	r2, [pc, #116]	; (8001cf8 <timer_init+0x8c>)
 8001c84:	2400      	movs	r4, #0
 8001c86:	f822 4013 	strh.w	r4, [r2, r3, lsl #1]
 8001c8a:	3301      	adds	r3, #1
 8001c8c:	2b04      	cmp	r3, #4
 8001c8e:	4625      	mov	r5, r4
 8001c90:	d1ef      	bne.n	8001c72 <timer_init+0x6>
 8001c92:	4b1a      	ldr	r3, [pc, #104]	; (8001cfc <timer_init+0x90>)
 8001c94:	2002      	movs	r0, #2
 8001c96:	2101      	movs	r1, #1
 8001c98:	601c      	str	r4, [r3, #0]
 8001c9a:	f7ff ff75 	bl	8001b88 <RCC_APB1PeriphClockCmd>
 8001c9e:	f8ad 4006 	strh.w	r4, [sp, #6]
 8001ca2:	f8ad 400c 	strh.w	r4, [sp, #12]
 8001ca6:	f8ad 400e 	strh.w	r4, [sp, #14]
 8001caa:	4c15      	ldr	r4, [pc, #84]	; (8001d00 <timer_init+0x94>)
 8001cac:	f44f 738c 	mov.w	r3, #280	; 0x118
 8001cb0:	f8ad 3004 	strh.w	r3, [sp, #4]
 8001cb4:	4620      	mov	r0, r4
 8001cb6:	2331      	movs	r3, #49	; 0x31
 8001cb8:	a901      	add	r1, sp, #4
 8001cba:	9302      	str	r3, [sp, #8]
 8001cbc:	f7ff ff72 	bl	8001ba4 <TIM_TimeBaseInit>
 8001cc0:	4620      	mov	r0, r4
 8001cc2:	2101      	movs	r1, #1
 8001cc4:	f7ff ffbe 	bl	8001c44 <TIM_Cmd>
 8001cc8:	68e3      	ldr	r3, [r4, #12]
 8001cca:	f043 0301 	orr.w	r3, r3, #1
 8001cce:	60e3      	str	r3, [r4, #12]
 8001cd0:	231d      	movs	r3, #29
 8001cd2:	f88d 3000 	strb.w	r3, [sp]
 8001cd6:	4668      	mov	r0, sp
 8001cd8:	2301      	movs	r3, #1
 8001cda:	f88d 5001 	strb.w	r5, [sp, #1]
 8001cde:	f88d 3002 	strb.w	r3, [sp, #2]
 8001ce2:	f88d 3003 	strb.w	r3, [sp, #3]
 8001ce6:	f000 fba3 	bl	8002430 <NVIC_Init>
 8001cea:	b005      	add	sp, #20
 8001cec:	bd30      	pop	{r4, r5, pc}
 8001cee:	bf00      	nop
 8001cf0:	200010a4 	.word	0x200010a4
 8001cf4:	20001098 	.word	0x20001098
 8001cf8:	20001090 	.word	0x20001090
 8001cfc:	200010a0 	.word	0x200010a0
 8001d00:	40000400 	.word	0x40000400

08001d04 <TIM3_IRQHandler>:
 8001d04:	2300      	movs	r3, #0
 8001d06:	4910      	ldr	r1, [pc, #64]	; (8001d48 <TIM3_IRQHandler+0x44>)
 8001d08:	f831 2013 	ldrh.w	r2, [r1, r3, lsl #1]
 8001d0c:	b292      	uxth	r2, r2
 8001d0e:	b132      	cbz	r2, 8001d1e <TIM3_IRQHandler+0x1a>
 8001d10:	f831 2013 	ldrh.w	r2, [r1, r3, lsl #1]
 8001d14:	3a01      	subs	r2, #1
 8001d16:	b292      	uxth	r2, r2
 8001d18:	f821 2013 	strh.w	r2, [r1, r3, lsl #1]
 8001d1c:	e009      	b.n	8001d32 <TIM3_IRQHandler+0x2e>
 8001d1e:	4a0b      	ldr	r2, [pc, #44]	; (8001d4c <TIM3_IRQHandler+0x48>)
 8001d20:	f832 2013 	ldrh.w	r2, [r2, r3, lsl #1]
 8001d24:	b292      	uxth	r2, r2
 8001d26:	f821 2013 	strh.w	r2, [r1, r3, lsl #1]
 8001d2a:	4a09      	ldr	r2, [pc, #36]	; (8001d50 <TIM3_IRQHandler+0x4c>)
 8001d2c:	2101      	movs	r1, #1
 8001d2e:	f822 1013 	strh.w	r1, [r2, r3, lsl #1]
 8001d32:	3301      	adds	r3, #1
 8001d34:	2b04      	cmp	r3, #4
 8001d36:	d1e6      	bne.n	8001d06 <TIM3_IRQHandler+0x2>
 8001d38:	4a06      	ldr	r2, [pc, #24]	; (8001d54 <TIM3_IRQHandler+0x50>)
 8001d3a:	4807      	ldr	r0, [pc, #28]	; (8001d58 <TIM3_IRQHandler+0x54>)
 8001d3c:	6813      	ldr	r3, [r2, #0]
 8001d3e:	2101      	movs	r1, #1
 8001d40:	3301      	adds	r3, #1
 8001d42:	6013      	str	r3, [r2, #0]
 8001d44:	f7ff bf8c 	b.w	8001c60 <TIM_ClearITPendingBit>
 8001d48:	200010a4 	.word	0x200010a4
 8001d4c:	20001098 	.word	0x20001098
 8001d50:	20001090 	.word	0x20001090
 8001d54:	200010a0 	.word	0x200010a0
 8001d58:	40000400 	.word	0x40000400

08001d5c <timer_get_time>:
 8001d5c:	b082      	sub	sp, #8
 8001d5e:	b672      	cpsid	i
 8001d60:	4b04      	ldr	r3, [pc, #16]	; (8001d74 <timer_get_time+0x18>)
 8001d62:	681b      	ldr	r3, [r3, #0]
 8001d64:	9301      	str	r3, [sp, #4]
 8001d66:	b662      	cpsie	i
 8001d68:	230a      	movs	r3, #10
 8001d6a:	9801      	ldr	r0, [sp, #4]
 8001d6c:	fbb0 f0f3 	udiv	r0, r0, r3
 8001d70:	b002      	add	sp, #8
 8001d72:	4770      	bx	lr
 8001d74:	200010a0 	.word	0x200010a0

08001d78 <timer_delay_ms>:
 8001d78:	b513      	push	{r0, r1, r4, lr}
 8001d7a:	4604      	mov	r4, r0
 8001d7c:	f7ff ffee 	bl	8001d5c <timer_get_time>
 8001d80:	4420      	add	r0, r4
 8001d82:	9001      	str	r0, [sp, #4]
 8001d84:	9c01      	ldr	r4, [sp, #4]
 8001d86:	f7ff ffe9 	bl	8001d5c <timer_get_time>
 8001d8a:	4284      	cmp	r4, r0
 8001d8c:	d902      	bls.n	8001d94 <timer_delay_ms+0x1c>
 8001d8e:	f000 fb4b 	bl	8002428 <sleep>
 8001d92:	e7f7      	b.n	8001d84 <timer_delay_ms+0xc>
 8001d94:	b002      	add	sp, #8
 8001d96:	bd10      	pop	{r4, pc}

08001d98 <event_timer_set_period>:
 8001d98:	b672      	cpsid	i
 8001d9a:	eb01 0181 	add.w	r1, r1, r1, lsl #2
 8001d9e:	4b07      	ldr	r3, [pc, #28]	; (8001dbc <event_timer_set_period+0x24>)
 8001da0:	0049      	lsls	r1, r1, #1
 8001da2:	b289      	uxth	r1, r1
 8001da4:	f823 1010 	strh.w	r1, [r3, r0, lsl #1]
 8001da8:	4b05      	ldr	r3, [pc, #20]	; (8001dc0 <event_timer_set_period+0x28>)
 8001daa:	f823 1010 	strh.w	r1, [r3, r0, lsl #1]
 8001dae:	4b05      	ldr	r3, [pc, #20]	; (8001dc4 <event_timer_set_period+0x2c>)
 8001db0:	2200      	movs	r2, #0
 8001db2:	f823 2010 	strh.w	r2, [r3, r0, lsl #1]
 8001db6:	b662      	cpsie	i
 8001db8:	4770      	bx	lr
 8001dba:	bf00      	nop
 8001dbc:	200010a4 	.word	0x200010a4
 8001dc0:	20001098 	.word	0x20001098
 8001dc4:	20001090 	.word	0x20001090

08001dc8 <event_timer_wait>:
 8001dc8:	b510      	push	{r4, lr}
 8001dca:	4604      	mov	r4, r0
 8001dcc:	4a06      	ldr	r2, [pc, #24]	; (8001de8 <event_timer_wait+0x20>)
 8001dce:	f832 3014 	ldrh.w	r3, [r2, r4, lsl #1]
 8001dd2:	b29b      	uxth	r3, r3
 8001dd4:	b913      	cbnz	r3, 8001ddc <event_timer_wait+0x14>
 8001dd6:	f000 fb27 	bl	8002428 <sleep>
 8001dda:	e7f7      	b.n	8001dcc <event_timer_wait+0x4>
 8001ddc:	b672      	cpsid	i
 8001dde:	2300      	movs	r3, #0
 8001de0:	f822 3014 	strh.w	r3, [r2, r4, lsl #1]
 8001de4:	b662      	cpsie	i
 8001de6:	bd10      	pop	{r4, pc}
 8001de8:	20001090 	.word	0x20001090

08001dec <USART_Init>:
 8001dec:	b530      	push	{r4, r5, lr}
 8001dee:	4604      	mov	r4, r0
 8001df0:	b099      	sub	sp, #100	; 0x64
 8001df2:	460d      	mov	r5, r1
 8001df4:	bf00      	nop
 8001df6:	bf00      	nop
 8001df8:	bf00      	nop
 8001dfa:	bf00      	nop
 8001dfc:	bf00      	nop
 8001dfe:	bf00      	nop
 8001e00:	bf00      	nop
 8001e02:	6803      	ldr	r3, [r0, #0]
 8001e04:	f023 0301 	bic.w	r3, r3, #1
 8001e08:	6003      	str	r3, [r0, #0]
 8001e0a:	6843      	ldr	r3, [r0, #4]
 8001e0c:	f423 5240 	bic.w	r2, r3, #12288	; 0x3000
 8001e10:	688b      	ldr	r3, [r1, #8]
 8001e12:	68c9      	ldr	r1, [r1, #12]
 8001e14:	4313      	orrs	r3, r2
 8001e16:	6043      	str	r3, [r0, #4]
 8001e18:	686a      	ldr	r2, [r5, #4]
 8001e1a:	6803      	ldr	r3, [r0, #0]
 8001e1c:	4311      	orrs	r1, r2
 8001e1e:	692a      	ldr	r2, [r5, #16]
 8001e20:	f423 53b0 	bic.w	r3, r3, #5632	; 0x1600
 8001e24:	430a      	orrs	r2, r1
 8001e26:	f023 030c 	bic.w	r3, r3, #12
 8001e2a:	4313      	orrs	r3, r2
 8001e2c:	6003      	str	r3, [r0, #0]
 8001e2e:	6883      	ldr	r3, [r0, #8]
 8001e30:	f423 7240 	bic.w	r2, r3, #768	; 0x300
 8001e34:	696b      	ldr	r3, [r5, #20]
 8001e36:	4313      	orrs	r3, r2
 8001e38:	6083      	str	r3, [r0, #8]
 8001e3a:	a801      	add	r0, sp, #4
 8001e3c:	f7ff fd12 	bl	8001864 <RCC_GetClocksFreq>
 8001e40:	4b17      	ldr	r3, [pc, #92]	; (8001ea0 <USART_Init+0xb4>)
 8001e42:	429c      	cmp	r4, r3
 8001e44:	d101      	bne.n	8001e4a <USART_Init+0x5e>
 8001e46:	9b0f      	ldr	r3, [sp, #60]	; 0x3c
 8001e48:	e00e      	b.n	8001e68 <USART_Init+0x7c>
 8001e4a:	4b16      	ldr	r3, [pc, #88]	; (8001ea4 <USART_Init+0xb8>)
 8001e4c:	429c      	cmp	r4, r3
 8001e4e:	d101      	bne.n	8001e54 <USART_Init+0x68>
 8001e50:	9b10      	ldr	r3, [sp, #64]	; 0x40
 8001e52:	e009      	b.n	8001e68 <USART_Init+0x7c>
 8001e54:	4b14      	ldr	r3, [pc, #80]	; (8001ea8 <USART_Init+0xbc>)
 8001e56:	429c      	cmp	r4, r3
 8001e58:	d101      	bne.n	8001e5e <USART_Init+0x72>
 8001e5a:	9b11      	ldr	r3, [sp, #68]	; 0x44
 8001e5c:	e004      	b.n	8001e68 <USART_Init+0x7c>
 8001e5e:	4b13      	ldr	r3, [pc, #76]	; (8001eac <USART_Init+0xc0>)
 8001e60:	429c      	cmp	r4, r3
 8001e62:	bf0c      	ite	eq
 8001e64:	9b12      	ldreq	r3, [sp, #72]	; 0x48
 8001e66:	9b13      	ldrne	r3, [sp, #76]	; 0x4c
 8001e68:	6822      	ldr	r2, [r4, #0]
 8001e6a:	6829      	ldr	r1, [r5, #0]
 8001e6c:	f412 4f00 	tst.w	r2, #32768	; 0x8000
 8001e70:	bf18      	it	ne
 8001e72:	005b      	lslne	r3, r3, #1
 8001e74:	fbb3 f2f1 	udiv	r2, r3, r1
 8001e78:	fb01 3312 	mls	r3, r1, r2, r3
 8001e7c:	ebb3 0f51 	cmp.w	r3, r1, lsr #1
 8001e80:	6823      	ldr	r3, [r4, #0]
 8001e82:	bf28      	it	cs
 8001e84:	3201      	addcs	r2, #1
 8001e86:	041b      	lsls	r3, r3, #16
 8001e88:	bf41      	itttt	mi
 8001e8a:	f64f 73f0 	movwmi	r3, #65520	; 0xfff0
 8001e8e:	f3c2 0142 	ubfxmi	r1, r2, #1, #3
 8001e92:	4013      	andmi	r3, r2
 8001e94:	ea41 0203 	orrmi.w	r2, r1, r3
 8001e98:	b292      	uxth	r2, r2
 8001e9a:	81a2      	strh	r2, [r4, #12]
 8001e9c:	b019      	add	sp, #100	; 0x64
 8001e9e:	bd30      	pop	{r4, r5, pc}
 8001ea0:	40013800 	.word	0x40013800
 8001ea4:	40004400 	.word	0x40004400
 8001ea8:	40004800 	.word	0x40004800
 8001eac:	40004c00 	.word	0x40004c00

08001eb0 <USART_Cmd>:
 8001eb0:	bf00      	nop
 8001eb2:	bf00      	nop
 8001eb4:	6803      	ldr	r3, [r0, #0]
 8001eb6:	b111      	cbz	r1, 8001ebe <USART_Cmd+0xe>
 8001eb8:	f043 0301 	orr.w	r3, r3, #1
 8001ebc:	e001      	b.n	8001ec2 <USART_Cmd+0x12>
 8001ebe:	f023 0301 	bic.w	r3, r3, #1
 8001ec2:	6003      	str	r3, [r0, #0]
 8001ec4:	4770      	bx	lr

08001ec6 <USART_ReceiveData>:
 8001ec6:	bf00      	nop
 8001ec8:	8c80      	ldrh	r0, [r0, #36]	; 0x24
 8001eca:	f3c0 0008 	ubfx	r0, r0, #0, #9
 8001ece:	4770      	bx	lr

08001ed0 <USART_ITConfig>:
 8001ed0:	b510      	push	{r4, lr}
 8001ed2:	bf00      	nop
 8001ed4:	bf00      	nop
 8001ed6:	bf00      	nop
 8001ed8:	f3c1 2407 	ubfx	r4, r1, #8, #8
 8001edc:	2301      	movs	r3, #1
 8001ede:	b2c9      	uxtb	r1, r1
 8001ee0:	2c02      	cmp	r4, #2
 8001ee2:	fa03 f301 	lsl.w	r3, r3, r1
 8001ee6:	d101      	bne.n	8001eec <USART_ITConfig+0x1c>
 8001ee8:	3004      	adds	r0, #4
 8001eea:	e002      	b.n	8001ef2 <USART_ITConfig+0x22>
 8001eec:	2c03      	cmp	r4, #3
 8001eee:	bf08      	it	eq
 8001ef0:	3008      	addeq	r0, #8
 8001ef2:	b112      	cbz	r2, 8001efa <USART_ITConfig+0x2a>
 8001ef4:	6802      	ldr	r2, [r0, #0]
 8001ef6:	4313      	orrs	r3, r2
 8001ef8:	e002      	b.n	8001f00 <USART_ITConfig+0x30>
 8001efa:	6802      	ldr	r2, [r0, #0]
 8001efc:	ea22 0303 	bic.w	r3, r2, r3
 8001f00:	6003      	str	r3, [r0, #0]
 8001f02:	bd10      	pop	{r4, pc}

08001f04 <USART_GetITStatus>:
 8001f04:	b510      	push	{r4, lr}
 8001f06:	bf00      	nop
 8001f08:	bf00      	nop
 8001f0a:	f3c1 2207 	ubfx	r2, r1, #8, #8
 8001f0e:	b2cc      	uxtb	r4, r1
 8001f10:	2301      	movs	r3, #1
 8001f12:	2a01      	cmp	r2, #1
 8001f14:	fa03 f304 	lsl.w	r3, r3, r4
 8001f18:	d101      	bne.n	8001f1e <USART_GetITStatus+0x1a>
 8001f1a:	6802      	ldr	r2, [r0, #0]
 8001f1c:	e003      	b.n	8001f26 <USART_GetITStatus+0x22>
 8001f1e:	2a02      	cmp	r2, #2
 8001f20:	bf0c      	ite	eq
 8001f22:	6842      	ldreq	r2, [r0, #4]
 8001f24:	6882      	ldrne	r2, [r0, #8]
 8001f26:	4013      	ands	r3, r2
 8001f28:	69c2      	ldr	r2, [r0, #28]
 8001f2a:	b13b      	cbz	r3, 8001f3c <USART_GetITStatus+0x38>
 8001f2c:	0c09      	lsrs	r1, r1, #16
 8001f2e:	2301      	movs	r3, #1
 8001f30:	408b      	lsls	r3, r1
 8001f32:	4213      	tst	r3, r2
 8001f34:	bf14      	ite	ne
 8001f36:	2001      	movne	r0, #1
 8001f38:	2000      	moveq	r0, #0
 8001f3a:	bd10      	pop	{r4, pc}
 8001f3c:	4618      	mov	r0, r3
 8001f3e:	bd10      	pop	{r4, pc}

08001f40 <USART_ClearITPendingBit>:
 8001f40:	bf00      	nop
 8001f42:	bf00      	nop
 8001f44:	2301      	movs	r3, #1
 8001f46:	0c09      	lsrs	r1, r1, #16
 8001f48:	408b      	lsls	r3, r1
 8001f4a:	6203      	str	r3, [r0, #32]
 8001f4c:	4770      	bx	lr
	...

08001f50 <uart_write>:
 8001f50:	4b04      	ldr	r3, [pc, #16]	; (8001f64 <uart_write+0x14>)
 8001f52:	69da      	ldr	r2, [r3, #28]
 8001f54:	0612      	lsls	r2, r2, #24
 8001f56:	d401      	bmi.n	8001f5c <uart_write+0xc>
 8001f58:	bf00      	nop
 8001f5a:	e7f9      	b.n	8001f50 <uart_write>
 8001f5c:	b280      	uxth	r0, r0
 8001f5e:	8518      	strh	r0, [r3, #40]	; 0x28
 8001f60:	4770      	bx	lr
 8001f62:	bf00      	nop
 8001f64:	40013800 	.word	0x40013800

08001f68 <uart_is_char>:
 8001f68:	4b0a      	ldr	r3, [pc, #40]	; (8001f94 <uart_is_char+0x2c>)
 8001f6a:	4a0b      	ldr	r2, [pc, #44]	; (8001f98 <uart_is_char+0x30>)
 8001f6c:	6819      	ldr	r1, [r3, #0]
 8001f6e:	6812      	ldr	r2, [r2, #0]
 8001f70:	4291      	cmp	r1, r2
 8001f72:	d00b      	beq.n	8001f8c <uart_is_char+0x24>
 8001f74:	681a      	ldr	r2, [r3, #0]
 8001f76:	4909      	ldr	r1, [pc, #36]	; (8001f9c <uart_is_char+0x34>)
 8001f78:	5c88      	ldrb	r0, [r1, r2]
 8001f7a:	681a      	ldr	r2, [r3, #0]
 8001f7c:	3201      	adds	r2, #1
 8001f7e:	601a      	str	r2, [r3, #0]
 8001f80:	681a      	ldr	r2, [r3, #0]
 8001f82:	2a0f      	cmp	r2, #15
 8001f84:	d904      	bls.n	8001f90 <uart_is_char+0x28>
 8001f86:	2200      	movs	r2, #0
 8001f88:	601a      	str	r2, [r3, #0]
 8001f8a:	4770      	bx	lr
 8001f8c:	f64f 70ff 	movw	r0, #65535	; 0xffff
 8001f90:	4770      	bx	lr
 8001f92:	bf00      	nop
 8001f94:	200010c0 	.word	0x200010c0
 8001f98:	200010bc 	.word	0x200010bc
 8001f9c:	200010ac 	.word	0x200010ac

08001fa0 <uart_read>:
 8001fa0:	b508      	push	{r3, lr}
 8001fa2:	f7ff ffe1 	bl	8001f68 <uart_is_char>
 8001fa6:	f64f 73ff 	movw	r3, #65535	; 0xffff
 8001faa:	4298      	cmp	r0, r3
 8001fac:	d101      	bne.n	8001fb2 <uart_read+0x12>
 8001fae:	bf00      	nop
 8001fb0:	e7f7      	b.n	8001fa2 <uart_read+0x2>
 8001fb2:	b2c0      	uxtb	r0, r0
 8001fb4:	bd08      	pop	{r3, pc}
	...

08001fb8 <uart_init>:
 8001fb8:	b530      	push	{r4, r5, lr}
 8001fba:	4b2c      	ldr	r3, [pc, #176]	; (800206c <uart_init+0xb4>)
 8001fbc:	4d2c      	ldr	r5, [pc, #176]	; (8002070 <uart_init+0xb8>)
 8001fbe:	2400      	movs	r4, #0
 8001fc0:	601c      	str	r4, [r3, #0]
 8001fc2:	4b2c      	ldr	r3, [pc, #176]	; (8002074 <uart_init+0xbc>)
 8001fc4:	b08b      	sub	sp, #44	; 0x2c
 8001fc6:	f44f 3000 	mov.w	r0, #131072	; 0x20000
 8001fca:	2101      	movs	r1, #1
 8001fcc:	601c      	str	r4, [r3, #0]
 8001fce:	f7ff fdbf 	bl	8001b50 <RCC_AHBPeriphClockCmd>
 8001fd2:	f44f 4080 	mov.w	r0, #16384	; 0x4000
 8001fd6:	2101      	movs	r1, #1
 8001fd8:	f7ff fdc8 	bl	8001b6c <RCC_APB2PeriphClockCmd>
 8001fdc:	f44f 63c0 	mov.w	r3, #1536	; 0x600
 8001fe0:	9302      	str	r3, [sp, #8]
 8001fe2:	2302      	movs	r3, #2
 8001fe4:	f88d 300c 	strb.w	r3, [sp, #12]
 8001fe8:	a902      	add	r1, sp, #8
 8001fea:	2303      	movs	r3, #3
 8001fec:	f04f 4090 	mov.w	r0, #1207959552	; 0x48000000
 8001ff0:	f88d 300d 	strb.w	r3, [sp, #13]
 8001ff4:	f88d 400e 	strb.w	r4, [sp, #14]
 8001ff8:	f88d 400f 	strb.w	r4, [sp, #15]
 8001ffc:	f000 fa5f 	bl	80024be <GPIO_Init>
 8002000:	f04f 4090 	mov.w	r0, #1207959552	; 0x48000000
 8002004:	2109      	movs	r1, #9
 8002006:	2207      	movs	r2, #7
 8002008:	f000 faa3 	bl	8002552 <GPIO_PinAFConfig>
 800200c:	2207      	movs	r2, #7
 800200e:	f04f 4090 	mov.w	r0, #1207959552	; 0x48000000
 8002012:	210a      	movs	r1, #10
 8002014:	f000 fa9d 	bl	8002552 <GPIO_PinAFConfig>
 8002018:	f44f 33e1 	mov.w	r3, #115200	; 0x1c200
 800201c:	9304      	str	r3, [sp, #16]
 800201e:	4628      	mov	r0, r5
 8002020:	230c      	movs	r3, #12
 8002022:	a904      	add	r1, sp, #16
 8002024:	9308      	str	r3, [sp, #32]
 8002026:	9405      	str	r4, [sp, #20]
 8002028:	9406      	str	r4, [sp, #24]
 800202a:	9407      	str	r4, [sp, #28]
 800202c:	9409      	str	r4, [sp, #36]	; 0x24
 800202e:	f7ff fedd 	bl	8001dec <USART_Init>
 8002032:	4628      	mov	r0, r5
 8002034:	2101      	movs	r1, #1
 8002036:	f7ff ff3b 	bl	8001eb0 <USART_Cmd>
 800203a:	2201      	movs	r2, #1
 800203c:	4628      	mov	r0, r5
 800203e:	490e      	ldr	r1, [pc, #56]	; (8002078 <uart_init+0xc0>)
 8002040:	f7ff ff46 	bl	8001ed0 <USART_ITConfig>
 8002044:	2325      	movs	r3, #37	; 0x25
 8002046:	f88d 4005 	strb.w	r4, [sp, #5]
 800204a:	f88d 4006 	strb.w	r4, [sp, #6]
 800204e:	a801      	add	r0, sp, #4
 8002050:	2401      	movs	r4, #1
 8002052:	f88d 3004 	strb.w	r3, [sp, #4]
 8002056:	f88d 4007 	strb.w	r4, [sp, #7]
 800205a:	f000 f9e9 	bl	8002430 <NVIC_Init>
 800205e:	4628      	mov	r0, r5
 8002060:	4621      	mov	r1, r4
 8002062:	f7ff ff25 	bl	8001eb0 <USART_Cmd>
 8002066:	b00b      	add	sp, #44	; 0x2c
 8002068:	bd30      	pop	{r4, r5, pc}
 800206a:	bf00      	nop
 800206c:	200010bc 	.word	0x200010bc
 8002070:	40013800 	.word	0x40013800
 8002074:	200010c0 	.word	0x200010c0
 8002078:	00050105 	.word	0x00050105

0800207c <USART1_IRQHandler>:
 800207c:	b508      	push	{r3, lr}
 800207e:	480d      	ldr	r0, [pc, #52]	; (80020b4 <USART1_IRQHandler+0x38>)
 8002080:	490d      	ldr	r1, [pc, #52]	; (80020b8 <USART1_IRQHandler+0x3c>)
 8002082:	f7ff ff3f 	bl	8001f04 <USART_GetITStatus>
 8002086:	b178      	cbz	r0, 80020a8 <USART1_IRQHandler+0x2c>
 8002088:	480a      	ldr	r0, [pc, #40]	; (80020b4 <USART1_IRQHandler+0x38>)
 800208a:	f7ff ff1c 	bl	8001ec6 <USART_ReceiveData>
 800208e:	4b0b      	ldr	r3, [pc, #44]	; (80020bc <USART1_IRQHandler+0x40>)
 8002090:	490b      	ldr	r1, [pc, #44]	; (80020c0 <USART1_IRQHandler+0x44>)
 8002092:	681a      	ldr	r2, [r3, #0]
 8002094:	b2c0      	uxtb	r0, r0
 8002096:	5488      	strb	r0, [r1, r2]
 8002098:	681a      	ldr	r2, [r3, #0]
 800209a:	3201      	adds	r2, #1
 800209c:	601a      	str	r2, [r3, #0]
 800209e:	681a      	ldr	r2, [r3, #0]
 80020a0:	2a0f      	cmp	r2, #15
 80020a2:	bf84      	itt	hi
 80020a4:	2200      	movhi	r2, #0
 80020a6:	601a      	strhi	r2, [r3, #0]
 80020a8:	4802      	ldr	r0, [pc, #8]	; (80020b4 <USART1_IRQHandler+0x38>)
 80020aa:	4903      	ldr	r1, [pc, #12]	; (80020b8 <USART1_IRQHandler+0x3c>)
 80020ac:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
 80020b0:	f7ff bf46 	b.w	8001f40 <USART_ClearITPendingBit>
 80020b4:	40013800 	.word	0x40013800
 80020b8:	00050105 	.word	0x00050105
 80020bc:	200010bc 	.word	0x200010bc
 80020c0:	200010ac 	.word	0x200010ac

080020c4 <uart_clear_buffer>:
 80020c4:	b672      	cpsid	i
 80020c6:	2300      	movs	r3, #0
 80020c8:	4a03      	ldr	r2, [pc, #12]	; (80020d8 <uart_clear_buffer+0x14>)
 80020ca:	2100      	movs	r1, #0
 80020cc:	54d1      	strb	r1, [r2, r3]
 80020ce:	3301      	adds	r3, #1
 80020d0:	2b10      	cmp	r3, #16
 80020d2:	d1f9      	bne.n	80020c8 <uart_clear_buffer+0x4>
 80020d4:	b662      	cpsie	i
 80020d6:	4770      	bx	lr
 80020d8:	200010ac 	.word	0x200010ac

080020dc <i2c_delay>:
 80020dc:	230b      	movs	r3, #11
 80020de:	3b01      	subs	r3, #1
 80020e0:	d001      	beq.n	80020e6 <i2c_delay+0xa>
 80020e2:	bf00      	nop
 80020e4:	e7fb      	b.n	80020de <i2c_delay+0x2>
 80020e6:	4770      	bx	lr

080020e8 <SetLowSDA>:
 80020e8:	b537      	push	{r0, r1, r2, r4, r5, lr}
 80020ea:	4d0d      	ldr	r5, [pc, #52]	; (8002120 <SetLowSDA+0x38>)
 80020ec:	2301      	movs	r3, #1
 80020ee:	2203      	movs	r2, #3
 80020f0:	2480      	movs	r4, #128	; 0x80
 80020f2:	f88d 3004 	strb.w	r3, [sp, #4]
 80020f6:	f88d 3006 	strb.w	r3, [sp, #6]
 80020fa:	4628      	mov	r0, r5
 80020fc:	2300      	movs	r3, #0
 80020fe:	4669      	mov	r1, sp
 8002100:	f88d 2005 	strb.w	r2, [sp, #5]
 8002104:	f88d 3007 	strb.w	r3, [sp, #7]
 8002108:	9400      	str	r4, [sp, #0]
 800210a:	f000 f9d8 	bl	80024be <GPIO_Init>
 800210e:	4628      	mov	r0, r5
 8002110:	4621      	mov	r1, r4
 8002112:	f000 fa1a 	bl	800254a <GPIO_ResetBits>
 8002116:	f7ff ffe1 	bl	80020dc <i2c_delay>
 800211a:	b003      	add	sp, #12
 800211c:	bd30      	pop	{r4, r5, pc}
 800211e:	bf00      	nop
 8002120:	48000400 	.word	0x48000400

08002124 <SetHighSDA>:
 8002124:	b537      	push	{r0, r1, r2, r4, r5, lr}
 8002126:	4d0d      	ldr	r5, [pc, #52]	; (800215c <SetHighSDA+0x38>)
 8002128:	2203      	movs	r2, #3
 800212a:	2300      	movs	r3, #0
 800212c:	2480      	movs	r4, #128	; 0x80
 800212e:	f88d 2005 	strb.w	r2, [sp, #5]
 8002132:	4628      	mov	r0, r5
 8002134:	2201      	movs	r2, #1
 8002136:	4669      	mov	r1, sp
 8002138:	f88d 3004 	strb.w	r3, [sp, #4]
 800213c:	f88d 2006 	strb.w	r2, [sp, #6]
 8002140:	f88d 3007 	strb.w	r3, [sp, #7]
 8002144:	9400      	str	r4, [sp, #0]
 8002146:	f000 f9ba 	bl	80024be <GPIO_Init>
 800214a:	4628      	mov	r0, r5
 800214c:	4621      	mov	r1, r4
 800214e:	f000 f9f8 	bl	8002542 <GPIO_SetBits>
 8002152:	f7ff ffc3 	bl	80020dc <i2c_delay>
 8002156:	b003      	add	sp, #12
 8002158:	bd30      	pop	{r4, r5, pc}
 800215a:	bf00      	nop
 800215c:	48000400 	.word	0x48000400

08002160 <SetLowSCL>:
 8002160:	b508      	push	{r3, lr}
 8002162:	4804      	ldr	r0, [pc, #16]	; (8002174 <SetLowSCL+0x14>)
 8002164:	2140      	movs	r1, #64	; 0x40
 8002166:	f000 f9f0 	bl	800254a <GPIO_ResetBits>
 800216a:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
 800216e:	f7ff bfb5 	b.w	80020dc <i2c_delay>
 8002172:	bf00      	nop
 8002174:	48000400 	.word	0x48000400

08002178 <SetHighSCL>:
 8002178:	b508      	push	{r3, lr}
 800217a:	4804      	ldr	r0, [pc, #16]	; (800218c <SetHighSCL+0x14>)
 800217c:	2140      	movs	r1, #64	; 0x40
 800217e:	f000 f9e0 	bl	8002542 <GPIO_SetBits>
 8002182:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
 8002186:	f7ff bfa9 	b.w	80020dc <i2c_delay>
 800218a:	bf00      	nop
 800218c:	48000400 	.word	0x48000400

08002190 <i2c_0_init>:
 8002190:	b507      	push	{r0, r1, r2, lr}
 8002192:	f44f 2080 	mov.w	r0, #262144	; 0x40000
 8002196:	2101      	movs	r1, #1
 8002198:	f7ff fcda 	bl	8001b50 <RCC_AHBPeriphClockCmd>
 800219c:	23c0      	movs	r3, #192	; 0xc0
 800219e:	9300      	str	r3, [sp, #0]
 80021a0:	2301      	movs	r3, #1
 80021a2:	2203      	movs	r2, #3
 80021a4:	480a      	ldr	r0, [pc, #40]	; (80021d0 <i2c_0_init+0x40>)
 80021a6:	f88d 3004 	strb.w	r3, [sp, #4]
 80021aa:	4669      	mov	r1, sp
 80021ac:	f88d 3006 	strb.w	r3, [sp, #6]
 80021b0:	2300      	movs	r3, #0
 80021b2:	f88d 2005 	strb.w	r2, [sp, #5]
 80021b6:	f88d 3007 	strb.w	r3, [sp, #7]
 80021ba:	f000 f980 	bl	80024be <GPIO_Init>
 80021be:	f7ff ffdb 	bl	8002178 <SetHighSCL>
 80021c2:	f7ff ff91 	bl	80020e8 <SetLowSDA>
 80021c6:	f7ff ffad 	bl	8002124 <SetHighSDA>
 80021ca:	b003      	add	sp, #12
 80021cc:	f85d fb04 	ldr.w	pc, [sp], #4
 80021d0:	48000400 	.word	0x48000400

080021d4 <i2cStart>:
 80021d4:	b508      	push	{r3, lr}
 80021d6:	f7ff ffcf 	bl	8002178 <SetHighSCL>
 80021da:	f7ff ffa3 	bl	8002124 <SetHighSDA>
 80021de:	f7ff ffcb 	bl	8002178 <SetHighSCL>
 80021e2:	f7ff ff81 	bl	80020e8 <SetLowSDA>
 80021e6:	f7ff ffbb 	bl	8002160 <SetLowSCL>
 80021ea:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
 80021ee:	f7ff bf99 	b.w	8002124 <SetHighSDA>

080021f2 <i2cStop>:
 80021f2:	b508      	push	{r3, lr}
 80021f4:	f7ff ffb4 	bl	8002160 <SetLowSCL>
 80021f8:	f7ff ff76 	bl	80020e8 <SetLowSDA>
 80021fc:	f7ff ffbc 	bl	8002178 <SetHighSCL>
 8002200:	f7ff ff72 	bl	80020e8 <SetLowSDA>
 8002204:	f7ff ffb8 	bl	8002178 <SetHighSCL>
 8002208:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
 800220c:	f7ff bf8a 	b.w	8002124 <SetHighSDA>

08002210 <i2cWrite>:
 8002210:	b538      	push	{r3, r4, r5, lr}
 8002212:	4605      	mov	r5, r0
 8002214:	2408      	movs	r4, #8
 8002216:	f7ff ffa3 	bl	8002160 <SetLowSCL>
 800221a:	062b      	lsls	r3, r5, #24
 800221c:	d502      	bpl.n	8002224 <i2cWrite+0x14>
 800221e:	f7ff ff81 	bl	8002124 <SetHighSDA>
 8002222:	e001      	b.n	8002228 <i2cWrite+0x18>
 8002224:	f7ff ff60 	bl	80020e8 <SetLowSDA>
 8002228:	3c01      	subs	r4, #1
 800222a:	f7ff ffa5 	bl	8002178 <SetHighSCL>
 800222e:	006d      	lsls	r5, r5, #1
 8002230:	f014 04ff 	ands.w	r4, r4, #255	; 0xff
 8002234:	b2ed      	uxtb	r5, r5
 8002236:	d1ee      	bne.n	8002216 <i2cWrite+0x6>
 8002238:	f7ff ff92 	bl	8002160 <SetLowSCL>
 800223c:	f7ff ff72 	bl	8002124 <SetHighSDA>
 8002240:	f7ff ff9a 	bl	8002178 <SetHighSCL>
 8002244:	4b05      	ldr	r3, [pc, #20]	; (800225c <i2cWrite+0x4c>)
 8002246:	8a1c      	ldrh	r4, [r3, #16]
 8002248:	b2a4      	uxth	r4, r4
 800224a:	f7ff ff89 	bl	8002160 <SetLowSCL>
 800224e:	f7ff ff45 	bl	80020dc <i2c_delay>
 8002252:	f084 0080 	eor.w	r0, r4, #128	; 0x80
 8002256:	f3c0 10c0 	ubfx	r0, r0, #7, #1
 800225a:	bd38      	pop	{r3, r4, r5, pc}
 800225c:	48000400 	.word	0x48000400

08002260 <i2cRead>:
 8002260:	b570      	push	{r4, r5, r6, lr}
 8002262:	4606      	mov	r6, r0
 8002264:	f7ff ff7c 	bl	8002160 <SetLowSCL>
 8002268:	f7ff ff5c 	bl	8002124 <SetHighSDA>
 800226c:	2508      	movs	r5, #8
 800226e:	2400      	movs	r4, #0
 8002270:	f7ff ff82 	bl	8002178 <SetHighSCL>
 8002274:	4b0d      	ldr	r3, [pc, #52]	; (80022ac <i2cRead+0x4c>)
 8002276:	8a1b      	ldrh	r3, [r3, #16]
 8002278:	0064      	lsls	r4, r4, #1
 800227a:	061b      	lsls	r3, r3, #24
 800227c:	b2e4      	uxtb	r4, r4
 800227e:	bf48      	it	mi
 8002280:	3401      	addmi	r4, #1
 8002282:	f105 35ff 	add.w	r5, r5, #4294967295	; 0xffffffff
 8002286:	bf48      	it	mi
 8002288:	b2e4      	uxtbmi	r4, r4
 800228a:	f7ff ff69 	bl	8002160 <SetLowSCL>
 800228e:	f015 05ff 	ands.w	r5, r5, #255	; 0xff
 8002292:	d1ed      	bne.n	8002270 <i2cRead+0x10>
 8002294:	b10e      	cbz	r6, 800229a <i2cRead+0x3a>
 8002296:	f7ff ff27 	bl	80020e8 <SetLowSDA>
 800229a:	f7ff ff6d 	bl	8002178 <SetHighSCL>
 800229e:	f7ff ff5f 	bl	8002160 <SetLowSCL>
 80022a2:	f7ff ff1b 	bl	80020dc <i2c_delay>
 80022a6:	4620      	mov	r0, r4
 80022a8:	bd70      	pop	{r4, r5, r6, pc}
 80022aa:	bf00      	nop
 80022ac:	48000400 	.word	0x48000400

080022b0 <i2c_write_reg>:
 80022b0:	b570      	push	{r4, r5, r6, lr}
 80022b2:	4606      	mov	r6, r0
 80022b4:	460d      	mov	r5, r1
 80022b6:	4614      	mov	r4, r2
 80022b8:	f7ff ff8c 	bl	80021d4 <i2cStart>
 80022bc:	4630      	mov	r0, r6
 80022be:	f7ff ffa7 	bl	8002210 <i2cWrite>
 80022c2:	4628      	mov	r0, r5
 80022c4:	f7ff ffa4 	bl	8002210 <i2cWrite>
 80022c8:	4620      	mov	r0, r4
 80022ca:	f7ff ffa1 	bl	8002210 <i2cWrite>
 80022ce:	e8bd 4070 	ldmia.w	sp!, {r4, r5, r6, lr}
 80022d2:	f7ff bf8e 	b.w	80021f2 <i2cStop>

080022d6 <i2c_read_reg>:
 80022d6:	b538      	push	{r3, r4, r5, lr}
 80022d8:	4604      	mov	r4, r0
 80022da:	460d      	mov	r5, r1
 80022dc:	f7ff ff7a 	bl	80021d4 <i2cStart>
 80022e0:	4620      	mov	r0, r4
 80022e2:	f7ff ff95 	bl	8002210 <i2cWrite>
 80022e6:	4628      	mov	r0, r5
 80022e8:	f7ff ff92 	bl	8002210 <i2cWrite>
 80022ec:	f7ff ff72 	bl	80021d4 <i2cStart>
 80022f0:	f044 0001 	orr.w	r0, r4, #1
 80022f4:	f7ff ff8c 	bl	8002210 <i2cWrite>
 80022f8:	2000      	movs	r0, #0
 80022fa:	f7ff ffb1 	bl	8002260 <i2cRead>
 80022fe:	4604      	mov	r4, r0
 8002300:	f7ff ff77 	bl	80021f2 <i2cStop>
 8002304:	4620      	mov	r0, r4
 8002306:	bd38      	pop	{r3, r4, r5, pc}

08002308 <SystemInit>:
 8002308:	4a39      	ldr	r2, [pc, #228]	; (80023f0 <SystemInit+0xe8>)
 800230a:	f8d2 3088 	ldr.w	r3, [r2, #136]	; 0x88
 800230e:	f443 0370 	orr.w	r3, r3, #15728640	; 0xf00000
 8002312:	f8c2 3088 	str.w	r3, [r2, #136]	; 0x88
 8002316:	4b37      	ldr	r3, [pc, #220]	; (80023f4 <SystemInit+0xec>)
 8002318:	681a      	ldr	r2, [r3, #0]
 800231a:	f042 0201 	orr.w	r2, r2, #1
 800231e:	601a      	str	r2, [r3, #0]
 8002320:	6859      	ldr	r1, [r3, #4]
 8002322:	4a35      	ldr	r2, [pc, #212]	; (80023f8 <SystemInit+0xf0>)
 8002324:	400a      	ands	r2, r1
 8002326:	605a      	str	r2, [r3, #4]
 8002328:	681a      	ldr	r2, [r3, #0]
 800232a:	f022 7284 	bic.w	r2, r2, #17301504	; 0x1080000
 800232e:	f422 3280 	bic.w	r2, r2, #65536	; 0x10000
 8002332:	601a      	str	r2, [r3, #0]
 8002334:	681a      	ldr	r2, [r3, #0]
 8002336:	f422 2280 	bic.w	r2, r2, #262144	; 0x40000
 800233a:	601a      	str	r2, [r3, #0]
 800233c:	685a      	ldr	r2, [r3, #4]
 800233e:	f422 02fe 	bic.w	r2, r2, #8323072	; 0x7f0000
 8002342:	605a      	str	r2, [r3, #4]
 8002344:	6ada      	ldr	r2, [r3, #44]	; 0x2c
 8002346:	f022 020f 	bic.w	r2, r2, #15
 800234a:	62da      	str	r2, [r3, #44]	; 0x2c
 800234c:	6b19      	ldr	r1, [r3, #48]	; 0x30
 800234e:	4a2b      	ldr	r2, [pc, #172]	; (80023fc <SystemInit+0xf4>)
 8002350:	b082      	sub	sp, #8
 8002352:	400a      	ands	r2, r1
 8002354:	631a      	str	r2, [r3, #48]	; 0x30
 8002356:	2200      	movs	r2, #0
 8002358:	609a      	str	r2, [r3, #8]
 800235a:	9200      	str	r2, [sp, #0]
 800235c:	9201      	str	r2, [sp, #4]
 800235e:	681a      	ldr	r2, [r3, #0]
 8002360:	f442 3280 	orr.w	r2, r2, #65536	; 0x10000
 8002364:	601a      	str	r2, [r3, #0]
 8002366:	681a      	ldr	r2, [r3, #0]
 8002368:	f402 3200 	and.w	r2, r2, #131072	; 0x20000
 800236c:	9201      	str	r2, [sp, #4]
 800236e:	9a00      	ldr	r2, [sp, #0]
 8002370:	3201      	adds	r2, #1
 8002372:	9200      	str	r2, [sp, #0]
 8002374:	9a01      	ldr	r2, [sp, #4]
 8002376:	b91a      	cbnz	r2, 8002380 <SystemInit+0x78>
 8002378:	9a00      	ldr	r2, [sp, #0]
 800237a:	f5b2 4fa0 	cmp.w	r2, #20480	; 0x5000
 800237e:	d1f2      	bne.n	8002366 <SystemInit+0x5e>
 8002380:	681a      	ldr	r2, [r3, #0]
 8002382:	f412 3200 	ands.w	r2, r2, #131072	; 0x20000
 8002386:	bf18      	it	ne
 8002388:	2201      	movne	r2, #1
 800238a:	9201      	str	r2, [sp, #4]
 800238c:	9a01      	ldr	r2, [sp, #4]
 800238e:	2a01      	cmp	r2, #1
 8002390:	d005      	beq.n	800239e <SystemInit+0x96>
 8002392:	4b17      	ldr	r3, [pc, #92]	; (80023f0 <SystemInit+0xe8>)
 8002394:	f04f 6200 	mov.w	r2, #134217728	; 0x8000000
 8002398:	609a      	str	r2, [r3, #8]
 800239a:	b002      	add	sp, #8
 800239c:	4770      	bx	lr
 800239e:	4a18      	ldr	r2, [pc, #96]	; (8002400 <SystemInit+0xf8>)
 80023a0:	2112      	movs	r1, #18
 80023a2:	6011      	str	r1, [r2, #0]
 80023a4:	685a      	ldr	r2, [r3, #4]
 80023a6:	605a      	str	r2, [r3, #4]
 80023a8:	685a      	ldr	r2, [r3, #4]
 80023aa:	605a      	str	r2, [r3, #4]
 80023ac:	685a      	ldr	r2, [r3, #4]
 80023ae:	f442 6280 	orr.w	r2, r2, #1024	; 0x400
 80023b2:	605a      	str	r2, [r3, #4]
 80023b4:	685a      	ldr	r2, [r3, #4]
 80023b6:	f422 127c 	bic.w	r2, r2, #4128768	; 0x3f0000
 80023ba:	605a      	str	r2, [r3, #4]
 80023bc:	685a      	ldr	r2, [r3, #4]
 80023be:	f442 12e8 	orr.w	r2, r2, #1900544	; 0x1d0000
 80023c2:	605a      	str	r2, [r3, #4]
 80023c4:	681a      	ldr	r2, [r3, #0]
 80023c6:	f042 7280 	orr.w	r2, r2, #16777216	; 0x1000000
 80023ca:	601a      	str	r2, [r3, #0]
 80023cc:	6819      	ldr	r1, [r3, #0]
 80023ce:	4a09      	ldr	r2, [pc, #36]	; (80023f4 <SystemInit+0xec>)
 80023d0:	0189      	lsls	r1, r1, #6
 80023d2:	d5fb      	bpl.n	80023cc <SystemInit+0xc4>
 80023d4:	6851      	ldr	r1, [r2, #4]
 80023d6:	f021 0103 	bic.w	r1, r1, #3
 80023da:	6051      	str	r1, [r2, #4]
 80023dc:	6851      	ldr	r1, [r2, #4]
 80023de:	f041 0102 	orr.w	r1, r1, #2
 80023e2:	6051      	str	r1, [r2, #4]
 80023e4:	685a      	ldr	r2, [r3, #4]
 80023e6:	f002 020c 	and.w	r2, r2, #12
 80023ea:	2a08      	cmp	r2, #8
 80023ec:	d1fa      	bne.n	80023e4 <SystemInit+0xdc>
 80023ee:	e7d0      	b.n	8002392 <SystemInit+0x8a>
 80023f0:	e000ed00 	.word	0xe000ed00
 80023f4:	40021000 	.word	0x40021000
 80023f8:	f87fc00c 	.word	0xf87fc00c
 80023fc:	ff00fccc 	.word	0xff00fccc
 8002400:	40022000 	.word	0x40022000

08002404 <sys_tick_init>:
 8002404:	4b05      	ldr	r3, [pc, #20]	; (800241c <sys_tick_init+0x18>)
 8002406:	4a06      	ldr	r2, [pc, #24]	; (8002420 <sys_tick_init+0x1c>)
 8002408:	605a      	str	r2, [r3, #4]
 800240a:	4a06      	ldr	r2, [pc, #24]	; (8002424 <sys_tick_init+0x20>)
 800240c:	21f0      	movs	r1, #240	; 0xf0
 800240e:	f882 1023 	strb.w	r1, [r2, #35]	; 0x23
 8002412:	2200      	movs	r2, #0
 8002414:	609a      	str	r2, [r3, #8]
 8002416:	2207      	movs	r2, #7
 8002418:	601a      	str	r2, [r3, #0]
 800241a:	4770      	bx	lr
 800241c:	e000e010 	.word	0xe000e010
 8002420:	00029040 	.word	0x00029040
 8002424:	e000ed00 	.word	0xe000ed00

08002428 <sleep>:
 8002428:	bf30      	wfi
 800242a:	4770      	bx	lr

0800242c <sytem_clock_init>:
 800242c:	f7ff bf6c 	b.w	8002308 <SystemInit>

08002430 <NVIC_Init>:
 8002430:	b510      	push	{r4, lr}
 8002432:	bf00      	nop
 8002434:	bf00      	nop
 8002436:	bf00      	nop
 8002438:	78c2      	ldrb	r2, [r0, #3]
 800243a:	7803      	ldrb	r3, [r0, #0]
 800243c:	b312      	cbz	r2, 8002484 <NVIC_Init+0x54>
 800243e:	4a17      	ldr	r2, [pc, #92]	; (800249c <NVIC_Init+0x6c>)
 8002440:	68d1      	ldr	r1, [r2, #12]
 8002442:	7842      	ldrb	r2, [r0, #1]
 8002444:	43c9      	mvns	r1, r1
 8002446:	f3c1 2102 	ubfx	r1, r1, #8, #3
 800244a:	f1c1 0404 	rsb	r4, r1, #4
 800244e:	b2e4      	uxtb	r4, r4
 8002450:	40a2      	lsls	r2, r4
 8002452:	b2d4      	uxtb	r4, r2
 8002454:	220f      	movs	r2, #15
 8002456:	410a      	asrs	r2, r1
 8002458:	7881      	ldrb	r1, [r0, #2]
 800245a:	400a      	ands	r2, r1
 800245c:	4322      	orrs	r2, r4
 800245e:	f103 4360 	add.w	r3, r3, #3758096384	; 0xe0000000
 8002462:	f503 4361 	add.w	r3, r3, #57600	; 0xe100
 8002466:	0112      	lsls	r2, r2, #4
 8002468:	b2d2      	uxtb	r2, r2
 800246a:	f883 2300 	strb.w	r2, [r3, #768]	; 0x300
 800246e:	7803      	ldrb	r3, [r0, #0]
 8002470:	2201      	movs	r2, #1
 8002472:	0959      	lsrs	r1, r3, #5
 8002474:	f003 031f 	and.w	r3, r3, #31
 8002478:	fa02 f303 	lsl.w	r3, r2, r3
 800247c:	4a08      	ldr	r2, [pc, #32]	; (80024a0 <NVIC_Init+0x70>)
 800247e:	f842 3021 	str.w	r3, [r2, r1, lsl #2]
 8002482:	bd10      	pop	{r4, pc}
 8002484:	095a      	lsrs	r2, r3, #5
 8002486:	2101      	movs	r1, #1
 8002488:	f003 031f 	and.w	r3, r3, #31
 800248c:	4099      	lsls	r1, r3
 800248e:	f102 0320 	add.w	r3, r2, #32
 8002492:	4a03      	ldr	r2, [pc, #12]	; (80024a0 <NVIC_Init+0x70>)
 8002494:	f842 1023 	str.w	r1, [r2, r3, lsl #2]
 8002498:	bd10      	pop	{r4, pc}
 800249a:	bf00      	nop
 800249c:	e000ed00 	.word	0xe000ed00
 80024a0:	e000e100 	.word	0xe000e100

080024a4 <lib_low_level_init>:
 80024a4:	b508      	push	{r3, lr}
 80024a6:	f7ff ffc1 	bl	800242c <sytem_clock_init>
 80024aa:	f000 f893 	bl	80025d4 <gpio_init>
 80024ae:	f7ff fd83 	bl	8001fb8 <uart_init>
 80024b2:	f7ff fbdb 	bl	8001c6c <timer_init>
 80024b6:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
 80024ba:	f7ff be69 	b.w	8002190 <i2c_0_init>

080024be <GPIO_Init>:
 80024be:	b5f0      	push	{r4, r5, r6, r7, lr}
 80024c0:	bf00      	nop
 80024c2:	bf00      	nop
 80024c4:	bf00      	nop
 80024c6:	bf00      	nop
 80024c8:	2300      	movs	r3, #0
 80024ca:	680e      	ldr	r6, [r1, #0]
 80024cc:	461c      	mov	r4, r3
 80024ce:	2501      	movs	r5, #1
 80024d0:	40a5      	lsls	r5, r4
 80024d2:	ea05 0e06 	and.w	lr, r5, r6
 80024d6:	45ae      	cmp	lr, r5
 80024d8:	d12d      	bne.n	8002536 <GPIO_Init+0x78>
 80024da:	790f      	ldrb	r7, [r1, #4]
 80024dc:	1e7a      	subs	r2, r7, #1
 80024de:	2a01      	cmp	r2, #1
 80024e0:	d817      	bhi.n	8002512 <GPIO_Init+0x54>
 80024e2:	bf00      	nop
 80024e4:	2203      	movs	r2, #3
 80024e6:	6885      	ldr	r5, [r0, #8]
 80024e8:	409a      	lsls	r2, r3
 80024ea:	ea25 0202 	bic.w	r2, r5, r2
 80024ee:	6082      	str	r2, [r0, #8]
 80024f0:	794d      	ldrb	r5, [r1, #5]
 80024f2:	6882      	ldr	r2, [r0, #8]
 80024f4:	409d      	lsls	r5, r3
 80024f6:	4315      	orrs	r5, r2
 80024f8:	6085      	str	r5, [r0, #8]
 80024fa:	bf00      	nop
 80024fc:	8882      	ldrh	r2, [r0, #4]
 80024fe:	b292      	uxth	r2, r2
 8002500:	ea22 020e 	bic.w	r2, r2, lr
 8002504:	8082      	strh	r2, [r0, #4]
 8002506:	798a      	ldrb	r2, [r1, #6]
 8002508:	8885      	ldrh	r5, [r0, #4]
 800250a:	40a2      	lsls	r2, r4
 800250c:	432a      	orrs	r2, r5
 800250e:	b292      	uxth	r2, r2
 8002510:	8082      	strh	r2, [r0, #4]
 8002512:	2203      	movs	r2, #3
 8002514:	6805      	ldr	r5, [r0, #0]
 8002516:	409a      	lsls	r2, r3
 8002518:	43d2      	mvns	r2, r2
 800251a:	4015      	ands	r5, r2
 800251c:	6005      	str	r5, [r0, #0]
 800251e:	6805      	ldr	r5, [r0, #0]
 8002520:	409f      	lsls	r7, r3
 8002522:	432f      	orrs	r7, r5
 8002524:	6007      	str	r7, [r0, #0]
 8002526:	68c7      	ldr	r7, [r0, #12]
 8002528:	4017      	ands	r7, r2
 800252a:	79ca      	ldrb	r2, [r1, #7]
 800252c:	fa02 f503 	lsl.w	r5, r2, r3
 8002530:	ea47 0205 	orr.w	r2, r7, r5
 8002534:	60c2      	str	r2, [r0, #12]
 8002536:	3401      	adds	r4, #1
 8002538:	2c10      	cmp	r4, #16
 800253a:	f103 0302 	add.w	r3, r3, #2
 800253e:	d1c6      	bne.n	80024ce <GPIO_Init+0x10>
 8002540:	bdf0      	pop	{r4, r5, r6, r7, pc}

08002542 <GPIO_SetBits>:
 8002542:	bf00      	nop
 8002544:	bf00      	nop
 8002546:	6181      	str	r1, [r0, #24]
 8002548:	4770      	bx	lr

0800254a <GPIO_ResetBits>:
 800254a:	bf00      	nop
 800254c:	bf00      	nop
 800254e:	8501      	strh	r1, [r0, #40]	; 0x28
 8002550:	4770      	bx	lr

08002552 <GPIO_PinAFConfig>:
 8002552:	b510      	push	{r4, lr}
 8002554:	bf00      	nop
 8002556:	bf00      	nop
 8002558:	bf00      	nop
 800255a:	f001 0307 	and.w	r3, r1, #7
 800255e:	08c9      	lsrs	r1, r1, #3
 8002560:	eb00 0081 	add.w	r0, r0, r1, lsl #2
 8002564:	009b      	lsls	r3, r3, #2
 8002566:	6a04      	ldr	r4, [r0, #32]
 8002568:	210f      	movs	r1, #15
 800256a:	4099      	lsls	r1, r3
 800256c:	ea24 0101 	bic.w	r1, r4, r1
 8002570:	6201      	str	r1, [r0, #32]
 8002572:	6a01      	ldr	r1, [r0, #32]
 8002574:	409a      	lsls	r2, r3
 8002576:	430a      	orrs	r2, r1
 8002578:	6202      	str	r2, [r0, #32]
 800257a:	bd10      	pop	{r4, pc}

0800257c <led_on>:
 800257c:	0401      	lsls	r1, r0, #16
 800257e:	bf42      	ittt	mi
 8002580:	4b08      	ldrmi	r3, [pc, #32]	; (80025a4 <led_on+0x28>)
 8002582:	f44f 4200 	movmi.w	r2, #32768	; 0x8000
 8002586:	619a      	strmi	r2, [r3, #24]
 8002588:	0702      	lsls	r2, r0, #28
 800258a:	bf42      	ittt	mi
 800258c:	f04f 4390 	movmi.w	r3, #1207959552	; 0x48000000
 8002590:	2208      	movmi	r2, #8
 8002592:	851a      	strhmi	r2, [r3, #40]	; 0x28
 8002594:	07c3      	lsls	r3, r0, #31
 8002596:	bf42      	ittt	mi
 8002598:	f04f 4390 	movmi.w	r3, #1207959552	; 0x48000000
 800259c:	2201      	movmi	r2, #1
 800259e:	619a      	strmi	r2, [r3, #24]
 80025a0:	4770      	bx	lr
 80025a2:	bf00      	nop
 80025a4:	48000400 	.word	0x48000400

080025a8 <led_off>:
 80025a8:	0401      	lsls	r1, r0, #16
 80025aa:	bf42      	ittt	mi
 80025ac:	4b08      	ldrmi	r3, [pc, #32]	; (80025d0 <led_off+0x28>)
 80025ae:	f44f 4200 	movmi.w	r2, #32768	; 0x8000
 80025b2:	851a      	strhmi	r2, [r3, #40]	; 0x28
 80025b4:	0702      	lsls	r2, r0, #28
 80025b6:	bf42      	ittt	mi
 80025b8:	f04f 4390 	movmi.w	r3, #1207959552	; 0x48000000
 80025bc:	2208      	movmi	r2, #8
 80025be:	619a      	strmi	r2, [r3, #24]
 80025c0:	07c3      	lsls	r3, r0, #31
 80025c2:	bf42      	ittt	mi
 80025c4:	f04f 4390 	movmi.w	r3, #1207959552	; 0x48000000
 80025c8:	2201      	movmi	r2, #1
 80025ca:	851a      	strhmi	r2, [r3, #40]	; 0x28
 80025cc:	4770      	bx	lr
 80025ce:	bf00      	nop
 80025d0:	48000400 	.word	0x48000400

080025d4 <gpio_init>:
 80025d4:	e92d 41f3 	stmdb	sp!, {r0, r1, r4, r5, r6, r7, r8, lr}
 80025d8:	f44f 3000 	mov.w	r0, #131072	; 0x20000
 80025dc:	2101      	movs	r1, #1
 80025de:	f7ff fab7 	bl	8001b50 <RCC_AHBPeriphClockCmd>
 80025e2:	f44f 2080 	mov.w	r0, #262144	; 0x40000
 80025e6:	2101      	movs	r1, #1
 80025e8:	f7ff fab2 	bl	8001b50 <RCC_AHBPeriphClockCmd>
 80025ec:	f44f 2000 	mov.w	r0, #524288	; 0x80000
 80025f0:	2101      	movs	r1, #1
 80025f2:	f7ff faad 	bl	8001b50 <RCC_AHBPeriphClockCmd>
 80025f6:	2400      	movs	r4, #0
 80025f8:	2501      	movs	r5, #1
 80025fa:	2603      	movs	r6, #3
 80025fc:	f44f 4800 	mov.w	r8, #32768	; 0x8000
 8002600:	4826      	ldr	r0, [pc, #152]	; (800269c <gpio_init+0xc8>)
 8002602:	f8cd 8000 	str.w	r8, [sp]
 8002606:	4669      	mov	r1, sp
 8002608:	2708      	movs	r7, #8
 800260a:	f88d 5004 	strb.w	r5, [sp, #4]
 800260e:	f88d 4006 	strb.w	r4, [sp, #6]
 8002612:	f88d 6005 	strb.w	r6, [sp, #5]
 8002616:	f88d 4007 	strb.w	r4, [sp, #7]
 800261a:	f7ff ff50 	bl	80024be <GPIO_Init>
 800261e:	f04f 4090 	mov.w	r0, #1207959552	; 0x48000000
 8002622:	4669      	mov	r1, sp
 8002624:	9700      	str	r7, [sp, #0]
 8002626:	f88d 5004 	strb.w	r5, [sp, #4]
 800262a:	f88d 4006 	strb.w	r4, [sp, #6]
 800262e:	f88d 6005 	strb.w	r6, [sp, #5]
 8002632:	f88d 4007 	strb.w	r4, [sp, #7]
 8002636:	f7ff ff42 	bl	80024be <GPIO_Init>
 800263a:	f04f 4090 	mov.w	r0, #1207959552	; 0x48000000
 800263e:	4669      	mov	r1, sp
 8002640:	9500      	str	r5, [sp, #0]
 8002642:	f88d 5004 	strb.w	r5, [sp, #4]
 8002646:	f88d 4006 	strb.w	r4, [sp, #6]
 800264a:	f88d 6005 	strb.w	r6, [sp, #5]
 800264e:	f88d 4007 	strb.w	r4, [sp, #7]
 8002652:	f7ff ff34 	bl	80024be <GPIO_Init>
 8002656:	f44f 7300 	mov.w	r3, #512	; 0x200
 800265a:	4669      	mov	r1, sp
 800265c:	480f      	ldr	r0, [pc, #60]	; (800269c <gpio_init+0xc8>)
 800265e:	9300      	str	r3, [sp, #0]
 8002660:	f88d 4004 	strb.w	r4, [sp, #4]
 8002664:	f88d 6005 	strb.w	r6, [sp, #5]
 8002668:	f88d 4007 	strb.w	r4, [sp, #7]
 800266c:	f7ff ff27 	bl	80024be <GPIO_Init>
 8002670:	4640      	mov	r0, r8
 8002672:	f7ff ff83 	bl	800257c <led_on>
 8002676:	4638      	mov	r0, r7
 8002678:	f7ff ff96 	bl	80025a8 <led_off>
 800267c:	4628      	mov	r0, r5
 800267e:	f7ff ff93 	bl	80025a8 <led_off>
 8002682:	f242 7311 	movw	r3, #10001	; 0x2711
 8002686:	3b01      	subs	r3, #1
 8002688:	d001      	beq.n	800268e <gpio_init+0xba>
 800268a:	bf00      	nop
 800268c:	e7fb      	b.n	8002686 <gpio_init+0xb2>
 800268e:	2001      	movs	r0, #1
 8002690:	f7ff ff74 	bl	800257c <led_on>
 8002694:	b002      	add	sp, #8
 8002696:	e8bd 81f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, pc}
 800269a:	bf00      	nop
 800269c:	48000400 	.word	0x48000400

080026a0 <get_key>:
 80026a0:	4b02      	ldr	r3, [pc, #8]	; (80026ac <get_key+0xc>)
 80026a2:	8a18      	ldrh	r0, [r3, #16]
 80026a4:	43c0      	mvns	r0, r0
 80026a6:	f400 7000 	and.w	r0, r0, #512	; 0x200
 80026aa:	4770      	bx	lr
 80026ac:	48000400 	.word	0x48000400

080026b0 <Default_Handler>:
 80026b0:	4668      	mov	r0, sp
 80026b2:	f020 0107 	bic.w	r1, r0, #7
 80026b6:	468d      	mov	sp, r1
 80026b8:	bf00      	nop
 80026ba:	e7fd      	b.n	80026b8 <Default_Handler+0x8>

080026bc <HardFault_Handler>:
 80026bc:	f44f 4000 	mov.w	r0, #32768	; 0x8000
 80026c0:	f7ff ff5c 	bl	800257c <led_on>
 80026c4:	4b06      	ldr	r3, [pc, #24]	; (80026e0 <HardFault_Handler+0x24>)
 80026c6:	3b01      	subs	r3, #1
 80026c8:	d001      	beq.n	80026ce <HardFault_Handler+0x12>
 80026ca:	bf00      	nop
 80026cc:	e7fb      	b.n	80026c6 <HardFault_Handler+0xa>
 80026ce:	f44f 4000 	mov.w	r0, #32768	; 0x8000
 80026d2:	f7ff ff69 	bl	80025a8 <led_off>
 80026d6:	4b02      	ldr	r3, [pc, #8]	; (80026e0 <HardFault_Handler+0x24>)
 80026d8:	3b01      	subs	r3, #1
 80026da:	d0ef      	beq.n	80026bc <HardFault_Handler>
 80026dc:	bf00      	nop
 80026de:	e7fb      	b.n	80026d8 <HardFault_Handler+0x1c>
 80026e0:	00989681 	.word	0x00989681

080026e4 <_reset_init>:
 80026e4:	490e      	ldr	r1, [pc, #56]	; (8002720 <_reset_init+0x3c>)
 80026e6:	4b0f      	ldr	r3, [pc, #60]	; (8002724 <_reset_init+0x40>)
 80026e8:	1a5b      	subs	r3, r3, r1
 80026ea:	109b      	asrs	r3, r3, #2
 80026ec:	2200      	movs	r2, #0
 80026ee:	429a      	cmp	r2, r3
 80026f0:	d006      	beq.n	8002700 <_reset_init+0x1c>
 80026f2:	480d      	ldr	r0, [pc, #52]	; (8002728 <_reset_init+0x44>)
 80026f4:	f850 0022 	ldr.w	r0, [r0, r2, lsl #2]
 80026f8:	f841 0022 	str.w	r0, [r1, r2, lsl #2]
 80026fc:	3201      	adds	r2, #1
 80026fe:	e7f6      	b.n	80026ee <_reset_init+0xa>
 8002700:	4a0a      	ldr	r2, [pc, #40]	; (800272c <_reset_init+0x48>)
 8002702:	f8d2 3088 	ldr.w	r3, [r2, #136]	; 0x88
 8002706:	f443 0370 	orr.w	r3, r3, #15728640	; 0xf00000
 800270a:	f8c2 3088 	str.w	r3, [r2, #136]	; 0x88
 800270e:	f502 720c 	add.w	r2, r2, #560	; 0x230
 8002712:	6853      	ldr	r3, [r2, #4]
 8002714:	f023 4340 	bic.w	r3, r3, #3221225472	; 0xc0000000
 8002718:	6053      	str	r3, [r2, #4]
 800271a:	f7ff b88f 	b.w	800183c <main>
 800271e:	bf00      	nop
 8002720:	20000000 	.word	0x20000000
 8002724:	20000030 	.word	0x20000030
 8002728:	080028c0 	.word	0x080028c0
 800272c:	e000ed00 	.word	0xe000ed00

08002730 <_init>:
 8002730:	e1a0c00d 	mov	ip, sp
 8002734:	e92ddff8 	push	{r3, r4, r5, r6, r7, r8, r9, sl, fp, ip, lr, pc}
 8002738:	e24cb004 	sub	fp, ip, #4
 800273c:	e24bd028 	sub	sp, fp, #40	; 0x28
 8002740:	e89d6ff0 	ldm	sp, {r4, r5, r6, r7, r8, r9, sl, fp, sp, lr}
 8002744:	e12fff1e 	bx	lr

08002748 <_fini>:
 8002748:	e1a0c00d 	mov	ip, sp
 800274c:	e92ddff8 	push	{r3, r4, r5, r6, r7, r8, r9, sl, fp, ip, lr, pc}
 8002750:	e24cb004 	sub	fp, ip, #4
 8002754:	e24bd028 	sub	sp, fp, #40	; 0x28
 8002758:	e89d6ff0 	ldm	sp, {r4, r5, r6, r7, r8, r9, sl, fp, sp, lr}
 800275c:	e12fff1e 	bx	lr
 8002760:	69647473 	.word	0x69647473
 8002764:	6e69206f 	.word	0x6e69206f
 8002768:	64207469 	.word	0x64207469
 800276c:	0a656e6f 	.word	0x0a656e6f
 8002770:	00          	.byte	0x00
 8002771:	31          	.byte	0x31
 8002772:	2e30      	.short	0x2e30
 8002774:	2e302e30 	.word	0x2e302e30
 8002778:	3231      	.short	0x3231
 800277a:	00          	.byte	0x00
 800277b:	41          	.byte	0x41
 800277c:	49432b54 	.word	0x49432b54
 8002780:	58554d50 	.word	0x58554d50
 8002784:	0a0d313d 	.word	0x0a0d313d
 8002788:	2b544100 	.word	0x2b544100
 800278c:	4d504943 	.word	0x4d504943
 8002790:	303d5855 	.word	0x303d5855
 8002794:	41000a0d 	.word	0x41000a0d
 8002798:	57432b54 	.word	0x57432b54
 800279c:	45444f4d 	.word	0x45444f4d
 80027a0:	0a0d313d 	.word	0x0a0d313d
 80027a4:	2b544100 	.word	0x2b544100
 80027a8:	414a5743 	.word	0x414a5743
 80027ac:	00223d50 	.word	0x00223d50
 80027b0:	4754454e 	.word	0x4754454e
 80027b4:	38524145 	.word	0x38524145
 80027b8:	656d0033 	.word	0x656d0033
 80027bc:	69646f6c 	.word	0x69646f6c
 80027c0:	6c696863 	.word	0x6c696863
 80027c4:	3634356c 	.word	0x3634356c
 80027c8:	0a0d2200 	.word	0x0a0d2200
 80027cc:	2b544100 	.word	0x2b544100
 80027d0:	53504943 	.word	0x53504943
 80027d4:	45565245 	.word	0x45565245
 80027d8:	2c313d52 	.word	0x2c313d52
 80027dc:	0a0d3038 	.word	0x0a0d3038
 80027e0:	2b544100 	.word	0x2b544100
 80027e4:	43504943 	.word	0x43504943
 80027e8:	45534f4c 	.word	0x45534f4c
 80027ec:	41000a0d 	.word	0x41000a0d
 80027f0:	49432b54 	.word	0x49432b54
 80027f4:	41545350 	.word	0x41545350
 80027f8:	223d5452 	.word	0x223d5452
 80027fc:	22504354 	.word	0x22504354
 8002800:	2200222c 	.word	0x2200222c
 8002804:	4f43002c 	.word	0x4f43002c
 8002808:	43454e4e 	.word	0x43454e4e
 800280c:	54410054 	.word	0x54410054
 8002810:	5049432b 	.word	0x5049432b
 8002814:	444e4553 	.word	0x444e4553
 8002818:	003e003d 	.word	0x003e003d
 800281c:	444e4553 	.word	0x444e4553
 8002820:	004b4f20 	.word	0x004b4f20
 8002824:	4450492b 	.word	0x4450492b
 8002828:	0000002c 	.word	0x0000002c
 800282c:	00000020 	.word	0x00000020
 8002830:	00000040 	.word	0x00000040
 8002834:	00000060 	.word	0x00000060
 8002838:	00000080 	.word	0x00000080
 800283c:	69727473 	.word	0x69727473
 8002840:	6120676e 	.word	0x6120676e
 8002844:	73697265 	.word	0x73697265
 8002848:	73656d20 	.word	0x73656d20
 800284c:	65676173 	.word	0x65676173
 8002850:	65740000 	.word	0x65740000
 8002854:	6e697473 	.word	0x6e697473
 8002858:	74732067 	.word	0x74732067
 800285c:	676e6972 	.word	0x676e6972
 8002860:	42424220 	.word	0x42424220
 8002864:	42424242 	.word	0x42424242
 8002868:	00343342 	.word	0x00343342
 800286c:	00          	.byte	0x00
 800286d:	65          	.byte	0x65
 800286e:	7272      	.short	0x7272
 8002870:	6320726f 	.word	0x6320726f
 8002874:	2065646f 	.word	0x2065646f
 8002878:	253a7525 	.word	0x253a7525
 800287c:	0a75      	.short	0x0a75
 800287e:	00          	.byte	0x00
 800287f:	0a          	.byte	0x0a
 8002880:	636c6577 	.word	0x636c6577
 8002884:	20656d6f 	.word	0x20656d6f
 8002888:	53206f74 	.word	0x53206f74
 800288c:	68757a75 	.word	0x68757a75
 8002890:	20534f61 	.word	0x20534f61
 8002894:	205e5f5e 	.word	0x205e5f5e
 8002898:	2e302e32 	.word	0x2e302e32
 800289c:	55420a36 	.word	0x55420a36
 80028a0:	20444c49 	.word	0x20444c49
 80028a4:	206e754a 	.word	0x206e754a
 80028a8:	32203331 	.word	0x32203331
 80028ac:	20363130 	.word	0x20363130
 80028b0:	333a3830 	.word	0x333a3830
 80028b4:	36313a34 	.word	0x36313a34
 80028b8:	0000000a 	.word	0x0000000a

080028bc <__EH_FRAME_BEGIN__>:
 80028bc:	00000000                                ....
